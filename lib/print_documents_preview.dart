import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';
import 'package:starial_app/print-document-model.dart';
import 'package:http/http.dart' as http;
import 'DocumentProvider.dart';

class PrintDocumentsPreview extends StatefulWidget {
  final FilePickerResult result;
  const PrintDocumentsPreview({super.key,required this.result});

  @override
  State<PrintDocumentsPreview> createState() => _PrintDocumentsPreviewState();
}

class _PrintDocumentsPreviewState extends State<PrintDocumentsPreview> {
  late FilePickerResult _currentResult;
  int noOfPages = 1;
  int totalCost = 0;
  int _currentIndex = 0;
  int colorPrintPrice = 10;
  int blackAndWhitePrintPrice = 3;
  // bool isColored = true;
  // bool isPortrait = true;
  late PageController _pageController;
  // late PdfController _pdfController;
  // late List<PdfController?> _pdfControllers;
  Map<String, PdfController> _pdfControllers = {};
  late List<Document> _documents;

  bool get isColored => _currentDocument?.colorPreference == 'colored';
  bool get isPortrait => _currentDocument?.orientation == 'portrait';

  Document? get _currentDocument =>
      (_documents.isNotEmpty && _currentIndex < _documents.length)
          ? _documents[_currentIndex]
          : null;

  void calculateTotal(){
    if(_currentDocument == null) return;

    final isCurrentColored = _currentDocument?.colorPreference == 'colored';
    // if(isColored) {
    if(isCurrentColored) {
      totalCost = colorPrintPrice * _currentDocument!.pages * _currentDocument!.copies;
    } else {
      totalCost = blackAndWhitePrintPrice * _currentDocument!.pages * _currentDocument!.copies;
    }
  }

  PdfController? _getPdfController(Document doc){
    if(doc.type != 'pdf' || doc.filePath.isEmpty) return null;
    // Return existing controller if available
    if(_pdfControllers.containsKey(doc.filePath)){
      return _pdfControllers[doc.filePath];
    }
    // Create a new controller
    final controller = PdfController(
      document: PdfDocument.openFile(doc.filePath),
      initialPage: 1,
    );
    _pdfControllers[doc.filePath] = controller;
    // Updating the page count when PDF loads
    controller.document.then((pdfDoc){
      if(!mounted) return;
      final documentProvider = context.read<DocumentProvider>();
      final updated = doc.copyWith(pages: pdfDoc.pagesCount);
      documentProvider.updateDocument(updated);
      if(_currentDocument?.id == doc.id){
        setState(() {
          noOfPages = updated.pages;
          calculateTotal();
        });
      }
    });

    return controller;
  }

  void _updateDocumentPreference(String property, dynamic value){
    if(_currentDocument == null) return;
    final documentProvider = context.read<DocumentProvider>();
    Document updatedDoc;
    if(property == 'colorPreference'){
      updatedDoc = _currentDocument!.copyWith(colorPreference: value);
    } else if(property == 'orientation'){
      updatedDoc = _currentDocument!.copyWith(orientation: value);
    }else{
      return;
    }
    
    documentProvider.updateDocument(updatedDoc);
    setState(() {
      calculateTotal();
    });
  }

  void _deleteCurrentDocument(){
    if(_currentDocument == null) return;
    final documentProvider = context.read<DocumentProvider>();
    final docToDel = _currentDocument!;
    final indexToDelete = _currentIndex;

    if(_pdfControllers.containsKey(docToDel.filePath)){
      _pdfControllers[docToDel.filePath]?.dispose();
      _pdfControllers.remove(docToDel.filePath);
    }
    documentProvider.deleteDocument(docToDel.id);

    final updatedDocuments = documentProvider.documents;
    if(updatedDocuments.isEmpty){
      Navigator.pop(context);
      return;
    }

    int newCurrentIdx;
    if(indexToDelete >= updatedDocuments.length){
      newCurrentIdx = updatedDocuments.length - 1;
    }else{
      newCurrentIdx = indexToDelete;
    }

    setState(() {
      _currentIndex = newCurrentIdx;
      noOfPages = updatedDocuments[_currentIndex].pages;
      calculateTotal();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _pageController.animateToPage(
          _currentIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<FilePickerResult?> _pickFile() async{
    try{
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'doc', 'docx', 'png', 'jpg', 'jpeg'],
          allowMultiple: true
      );
      if(result != null){
        const int maxSizeInBytes = 10 * 1024 * 1024;
        List<PlatformFile> validFiles = [];
        List<String> overSizedFiles = [];

        for(PlatformFile file in result.files){
          if(file.size <= maxSizeInBytes){
            validFiles.add(file);
          }else{
            overSizedFiles.add(file.name);
          }
        }

        if(overSizedFiles.isNotEmpty){
          print('Files too large (>10MB): ${overSizedFiles.join(', ')}');
        }

        if(validFiles.isNotEmpty){
          return FilePickerResult(validFiles);
        }else{
          return null;
        }
      }
      return result;
    }catch(e){
      print('Error picking files: $e');
      return null;
    }
  }

  Future<bool> _placeOrder(List<Document> documents, String userId, int amountPayable) async{
    try{
      final url = Uri.parse('https://starial.store/app/v1/api/print-orders/store');
      final List<Map<String, dynamic>> documentsJson = documents.map((doc) => doc.toJson()).toList();

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-F-8',
        },
        body: jsonEncode({
          'userId': userId,
          'documents': documentsJson,
          'amountPayable': amountPayable
        }),
      );
      final responseBody = response.body;
      print('Response Status: ${response.statusCode}');
      print('Response Body: $responseBody');
      return response.statusCode == 200 || response.statusCode == 201;
    }catch(e){
      print('Unable to place order: ${e.toString()}');
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _currentResult = widget.result;
    _pageController = PageController(initialPage: _currentIndex);
    final documentProvider = context.read<DocumentProvider>();

    // Add initial documents
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (documentProvider.documents.isEmpty && _currentResult.files.isNotEmpty) {
          for (var file in _currentResult.files) {
            final path = file.path ?? '';
            final isPdf = (file.extension?.toLowerCase() == 'pdf') || path.toLowerCase().endsWith('.pdf');
            documentProvider.addDocument(Document(
                id: DateTime.now().millisecondsSinceEpoch +  _currentResult.files.indexOf(file),
                title: file.name,
                orientation: 'portrait',
                colorPreference: 'black and white',
                pages: 1,
                type: isPdf ? 'pdf' : (path.toLowerCase().contains(RegExp(r'\.(png|jpg|jpeg)$')) ? 'image' : 'unknown'),
                filePath: path, totalCost: 0)
            );
          }
      }
    });
    // _pdfControllers = <PdfController?>[];
    // print('PDFControllers in initState(): $_pdfControllers');
    // _documents = documentProvider.documents;
    // print('_documents: $_documents');

    // _pageController = PageController(initialPage: _currentIndex);
    // if (_documents.isNotEmpty &&
    //     _documents.first.filePath.isNotEmpty &&
    //     _documents.first.filePath.endsWith('pdf')) {
    //   _pdfController = PdfController(
    //     document: PdfDocument.openFile(_documents.first.filePath),
    //     initialPage: 1,
    //   );
    // }
    // _pdfControllers = List.generate(_documents.length, (index) {
    //   if (_documents[index].type == 'pdf' && _documents[index].filePath.isNotEmpty) {
    //     return PdfController(
    //       document: PdfDocument.openFile(_documents[index].filePath),
    //       initialPage: 1,
    //     );
    //   }
    //   return null;
    // });


    // if (_documents.isNotEmpty && _documents.first.filePath.isNotEmpty && _documents.first.filePath.endsWith('pdf')) {
    //   final firstPdfController = _pdfControllers.firstWhere((controller) => controller != null, orElse: () => null);
    //   if (firstPdfController != null) {
    //     _pdfController = firstPdfController;
    //     _pdfController.document.then((doc) {
    //       setState(() => noOfPages = doc.pagesCount);
    //       calculateTotal();
    //     });
    //   }
    // }
    // for (int i = 0; i < _documents.length; i++) {
    //   if (mounted && _documents[i].type == 'pdf' && _pdfControllers.length > i
    //       && _pdfControllers[i] != null) {
    //     _pdfControllers[i]!.document.then((doc) {
    //       if(mounted){
    //         setState(() {
    //           _documents[i] = _documents[i].copyWith(pages: doc.pagesCount);
    //           documentProvider.updateDocument(_documents[i]);
    //           if (i == _currentIndex) {
    //             noOfPages = doc.pagesCount;
    //             calculateTotal();
    //           }
    //         });
    //       }
    //     });
    //   }
    // }
    // for (int i = 0; i < _documents.length; i++) {
    //   if (_documents[i].type == 'pdf' && _pdfControllers[i] != null) {
    //     _pdfControllers[i]!.document.then((doc) {
    //       if (!mounted) return;
    //       setState(() {
    //         _documents[i] = _documents[i].copyWith(pages: doc.pagesCount);
    //         documentProvider.updateDocument(_documents[i]);
    //         if (i == _currentIndex) {
    //           noOfPages = doc.pagesCount;
    //           calculateTotal();
    //         }
    //       });
    //     });
    //   }
    // }

    // print("Documents in initState: $_documents");
    // print("PDF Controllers initState: $_pdfControllers");
    // setState(() {});
    // calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<DocumentProvider>(builder: (context, documentProvider, __) {
        _documents = documentProvider.documents;
        // Handling empty documents
        if(_documents.isEmpty){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox_outlined, size: 100, color: Colors.grey),
                Text('No documents to preview'),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Go Back'),
                ),
              ],
            ),
          );
        }

        if(_currentIndex >= _documents.length){
          _currentIndex = _documents.length - 1;
        }

        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.53,
                    width: double.infinity,
                    // height: 480,
                    decoration: BoxDecoration(
                      color: Color(0xFFF4F4F4),
                    ),
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.65,
                                height: MediaQuery.of(context).size.height * 0.38,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(2)
                                ),
                                margin: EdgeInsets.only(bottom: 7),
                                child: PageView.builder(
                                  controller: _pageController,
                                  itemCount: _documents.length,
                                  onPageChanged: (index) {
                                    setState(() {
                                      _currentIndex = index;
                                      noOfPages = _documents[index].pages;
                                      calculateTotal();
                                    });
                                  },
                                  itemBuilder: (context, index) {
                                    final document = _documents[index];
                                    final docIsColored = document.colorPreference == 'colored';
                                    final docIsPortrait = document.orientation == 'portrait';
                                    // return Image.network(
                                    //   _imageUrls[index],
                                    //   fit: BoxFit.cover,
                                    // );
                                    if(document.type == 'image' && document.filePath.isNotEmpty) {
                                      return AnimatedRotation(
                                        turns: docIsPortrait ? 0 : 0.25,
                                        duration: Duration(seconds: 1),
                                        curve: Curves.easeInOut,
                                        child: Padding(
                                          // padding: const EdgeInsets.all(20.0),
                                          // child: Image.asset(
                                          //   'assets/images/${document.title}',
                                          //   fit: BoxFit.cover,
                                          //   color: docIsColored ? null : Colors.grey,
                                          //   colorBlendMode: docIsColored ? null : BlendMode.saturation,
                                          // ),
                                          padding: const EdgeInsets.all(20.0),
                                          child: Image.file(
                                            File(document.filePath),
                                            fit: BoxFit.contain,
                                            color: docIsColored ? null : Colors.grey,
                                            colorBlendMode: docIsColored ? null : BlendMode.saturation,
                                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                              print('Error loading image: ${document.filePath}');
                                              print('Exception: $exception');
                                              return Center(
                                                child: Text('Error loading image. Please check the file path and format.',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(color: Colors.red)
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      );
                                    }
                                    if(document.type == 'pdf' && document.filePath.isNotEmpty) {
                                      final controller = _getPdfController(document);
                                      return IgnorePointer(
                                        ignoring: true,
                                        child: ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                            docIsColored ? Colors.transparent : Colors.white,
                                            docIsColored ? BlendMode.dst : BlendMode.saturation,
                                          ),
                                          child: AnimatedRotation(
                                            turns: docIsPortrait ? 0 : 0.25,
                                            duration: Duration(seconds: 1),
                                            curve: Curves.easeInOut,
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.65,
                                                height: docIsPortrait ? 345 : 300,
                                                // child: _pdfControllers.isNotEmpty && index < _pdfControllers.length && _pdfControllers[index] != null
                                                child: controller != null ? PdfView(
                                                        // controller: _pdfControllers[index]!,
                                                        controller: controller,
                                                        renderer: (PdfPage page) {
                                                          return page.render(
                                                            width: page.width * 2,
                                                            height: page.height * 2,
                                                            format: PdfPageImageFormat.png,
                                                            backgroundColor: '#ffffff',
                                                          );
                                                        },
                                                        scrollDirection: Axis.vertical,
                                                        pageSnapping: true,
                                                        onPageChanged: (page) {
                                                          if (page != 1) {
                                                            Future.microtask(() {
                                                              // _pdfControllers[index]?.jumpToPage(1);
                                                              controller.jumpToPage(1);
                                                            });
                                                          }
                                                        },
                                                      )
                                                    : Center(child: CircularProgressIndicator()),
                                              )
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return Icon(Icons.inbox_outlined,size: 100,color: Colors.grey,);
                                  },
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  child: IconButton(
                                      iconSize: 15,
                                      padding: EdgeInsets.all(5.0),
                                      constraints: BoxConstraints(),
                                      style: IconButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          side: BorderSide(color: Colors.grey.shade300)
                                      ),
                                      onPressed: _deleteCurrentDocument,
                                      icon: Icon(Icons.close,size: 20,)
                                  )
                              )
                            ]
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // children: _documents.map((doc) {
                              // int index = _documents.indexOf(doc);
                            children: _documents.asMap().entries.map((entry) {
                              int index = entry.key;
                              return InkWell(
                                onTap: (){
                                  _pageController.animateToPage(
                                    index,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Container(
                                  width: 20.0,
                                  height: 5.0,
                                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: _currentIndex == index ? Color(0xFF0B8DFF) : Colors.grey.shade400,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10,top: 10, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Number of Copies', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),),
                            Text('File ${_currentIndex + 1} (${_currentDocument?.pages ?? 1} ${_currentDocument?.pages == 1 ? 'page' : 'pages'})', style: TextStyle(fontSize: 14),)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: (){
                                    // Decreasing number of copies
                                    if(_currentDocument != null && _currentDocument!.copies > 1){
                                      documentProvider.decrementNoOfCopies(_currentDocument!.id);
                                      setState(() {
                                        calculateTotal();
                                      });
                                    }
                                  },
                                  child: Icon(Icons.remove,color: Color(0xFF0B8DFF),),
                                ),
                                Text(_currentDocument!.copies.toString(),style: TextStyle(color: Color(0xFF0B8DFF),fontWeight: FontWeight.bold,fontSize: 18),),
                                InkWell(
                                  onTap: (){
                                    // Increasing number of copies
                                    if(_currentDocument != null){
                                      documentProvider.incrementNoOfCopies(_currentDocument!.id);
                                      setState(() {
                                        calculateTotal();
                                      });
                                    }
                                  },
                                  child: Icon(Icons.add,color: Color(0xFF0B8DFF),),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(color: Colors.grey.shade200,),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10,top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Color Preference', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                            SizedBox(height: 5,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    // onTap: (){
                                      // setState(() {
                                        // isColored = true;
                                        // calculateTotal();
                                      // });
                                    // },
                                    onTap: () => _updateDocumentPreference('colorPreference', 'colored'),
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: isColored ? Colors.blue.shade50 : Colors.white,
                                          border: Border.all(
                                              color: isColored ? Color(0xFF0B8DFF) : Colors.grey.shade300,
                                              width: isColored ? 2 : 1
                                          )
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/images/color-wheel.png',height: 35,),
                                          SizedBox(width: 20,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('Colored',style: TextStyle(fontSize: 14,color: Colors.black),),
                                              Text('\u20B9$colorPrintPrice/page',style: TextStyle(fontSize: 12,color: Colors.black54),)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Expanded(
                                  child: InkWell(
                                    // onTap: (){
                                    //   setState(() {
                                    //     isColored = false;
                                    //     calculateTotal();
                                    //   });
                                    // },
                                    onTap: ()=> _updateDocumentPreference('colorPreference', 'black and white'),
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: isColored ? Colors.white : Colors.blue.shade50,
                                          border: Border.all(color: isColored ? Colors.grey.shade300 : Color(0xFF0B8DFF),width: isColored ? 1 : 2)
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        children: [
                                          Image.asset('assets/images/black-and-white.png',height: 30,),
                                          SizedBox(width: 20,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('Black & White',style: TextStyle(fontSize: 14),),
                                              Text('\u20B9$blackAndWhitePrintPrice/page',style: TextStyle(fontSize: 12,color: Colors.black54),)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Orientation', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    // onTap: (){
                                    //   setState(() {
                                    //     isPortrait = true;
                                    //   });
                                    // },
                                    onTap: () => _updateDocumentPreference('orientation', 'portrait'),
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: isPortrait ? Colors.blue.shade50 : Colors.white,
                                          border: Border.all(color: isPortrait ? Color(0xFF0B8DFF) : Colors.grey.shade300,width: isPortrait ? 2 : 1)
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset('assets/images/portrait-view.svg',height: 30,),
                                          SizedBox(width: 20,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('Portrait',style: TextStyle(fontSize: 14),),
                                              Text('8.3 x 11.7 in',style: TextStyle(fontSize: 12,color: Colors.black54),)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Expanded(
                                  child: InkWell(
                                    // onTap: (){
                                    //   setState(() {
                                    //     isPortrait = false;
                                    //   });
                                    // },
                                    onTap: () => _updateDocumentPreference('orientation', 'landscape'),
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: isPortrait ? Colors.white : Colors.blue.shade50,
                                          border: Border.all(color: isPortrait ? Colors.grey.shade300 : Color(0xFF0B8DFF),width: isPortrait ? 1 : 2)
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset('assets/images/landscape-view.svg',height: 30,),
                                          SizedBox(width: 20,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('Landscape',style: TextStyle(fontSize: 14),),
                                              Text('11.7 x 8.3 in',style: TextStyle(fontSize: 12,color: Colors.black54),)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 10, spreadRadius: 1
                              )
                            ]
                          ),
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  // backgroundColor: Color(0xFF0B8DFF),
                                  backgroundColor: Colors.white,
                                  // foregroundColor: Color(0xFF0B8DFF),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                  shadowColor: Colors.grey.shade300,
                              ),
                              onPressed: () async{
                                FilePickerResult? result = await _pickFile();
                                if(result == null) return;
                                // setState(() {
                                //   _currentResult.files.addAll(result.files);
                                //   final newPdfControllers = List.generate(result.files.length, (index) {
                                //     final file = result.files[index];
                                //     if (file.path != null && file.path!.endsWith('pdf')) {
                                //       return PdfController(
                                //         document: PdfDocument.openFile(file.path!),
                                //         initialPage: 1,
                                //       );
                                //     }
                                //     return null;
                                //   });
                                //   _pdfControllers.addAll(newPdfControllers);
                                //   if (result.files.isNotEmpty) {
                                //     _pageController.jumpToPage(_currentResult.files.length - result.files.length + 1);
                                //   }
                                //   calculateTotal();
                                // });

                                final documentProvider = context.read<DocumentProvider>();
                                for (final file in result.files) {
                                  final path = file.path ?? '';
                                  final isPdf = (file.extension?.toLowerCase() == 'pdf') || path.toLowerCase().endsWith('.pdf');
                                  documentProvider.addDocument(Document(
                                    id: DateTime.now().millisecondsSinceEpoch + result.files.indexOf(file),
                                    title: file.name,
                                    orientation: 'portrait',
                                    colorPreference: 'black and white',
                                    pages: 1,
                                    type: isPdf ? 'pdf' : (path.toLowerCase().contains(RegExp(r'\.(png|jpg|jpeg)$'))) ? 'image' : 'unknown',
                                    filePath: path,
                                    totalCost: 0,
                                  ));
                                }

                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  if (!mounted) return;
                                  _pageController.animateToPage(
                                    documentProvider.documents.length - 1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Add More', style: TextStyle(
                                     color: Color(0xFF0B8DFF),fontWeight: FontWeight.bold, fontSize: 18,)
                                  ),
                                  SizedBox(width: 5,),
                                  Icon(Icons.add, color: Color(0xFF0B8DFF),size: 25,)
                                ],
                              )
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
                left: 10, top: 40,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                    ),
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Icon(Icons.arrow_back_ios_new,color: Colors.black),
                  ),
                )
            ),
            Positioned(
                bottom: 0, left: 0, right: 0,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 5,
                            spreadRadius: 2
                        )
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Total $noOfPages ${noOfPages == 1 ? 'page' : 'pages'}',style: TextStyle(fontSize: 16,color: Colors.black),),
                            Text('\u20B9$totalCost', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: InkWell(
                          onTap: () async{
                            final documentProvider = context.read<DocumentProvider>();
                            var amountPayable = 0;
                            // Add to cart functionality
                            for(var doc in _documents){
                              final costForThisDoc = (doc.colorPreference == 'colored' ? colorPrintPrice : blackAndWhitePrintPrice) * doc.pages * doc.copies;
                              final updatedDoc = doc.copyWith(
                                totalCost: costForThisDoc
                              );
                              documentProvider.updateDocument(updatedDoc);
                              amountPayable += costForThisDoc;
                            }
                            // API call to place order
                            final res = await _placeOrder(documentProvider.documents, '', amountPayable);
                            if(res){
                              print('Order placed successfully. ${jsonDecode((documentProvider.documents).toString())}');
                            }else{
                              print('Unable to place order.');
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [Color(0xFF61D5FF),Color(0xFF0084FF)],)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            alignment: Alignment.center,
                            child: Text('Add to cart',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                          ),
                        ),
                      )
                    ],
                  ),
                )
            )
          ],
        );
      })
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _pdfControllers.values) {
      controller.dispose();
    }
    _pdfControllers.clear();
    super.dispose();
  }
}
