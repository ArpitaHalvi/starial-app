import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:starial_app/print_documents_preview.dart';
import 'package:starial_app/scan_file.dart';

class PrintDocument extends StatefulWidget {
  const PrintDocument({super.key});

  @override
  State<PrintDocument> createState() => _PrintDocumentState();
}

class _PrintDocumentState extends State<PrintDocument> {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async{
                  FilePickerResult? result = await _pickFile();
                  if(result != null){
                    // final scanResult = await Navigator.push<bool>(
                    //   context, MaterialPageRoute(builder: (context) => ScanFile(result: result,),),
                    // );
                    // print('Scan Result: $scanResult');
                    // if (!mounted) return;
                    // if (scanResult == true) {
                    //   Navigator.push(
                    //     context, MaterialPageRoute(builder: (context) => PrintDocumentsPreview(result: result),),
                    //   );
                    // }
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => PrintDocumentsPreview(result: result),),
                    );
                  }
                },
                child: Text('Pick File >>>', style: TextStyle(fontSize: 22),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}