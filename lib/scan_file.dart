// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class ScanFile extends StatefulWidget {
//   const ScanFile({super.key});
//
//   @override
//   State<ScanFile> createState() => _FileScannedState();
// }
//
// class _FileScannedState extends State<ScanFile> with SingleTickerProviderStateMixin{
//   late Animation rippleAnimation;
//   late AnimationController animationController;
//   var listRadius = [100.0,150.0,200.0,250.0,300.0];
//
//   @override
//   void initState() {
//     super.initState();
//     // animationController = AnimationController(vsync: this, duration: Duration(seconds: 3), lowerBound: 0.5);
//     animationController = AnimationController(vsync: this, duration: Duration(seconds: 3),lowerBound: 0);
//     rippleAnimation = Tween(begin: 0.0, end: 1.0).animate(animationController);
//     animationController.addListener((){
//       setState(() {});
//     });
//     animationController.repeat(reverse: true);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 300,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   ...listRadius.map((rad) => Container(
//                       width: rad*rippleAnimation.value,height: rad*rippleAnimation.value,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.blue.withAlpha(((1 - rippleAnimation.value) * 255).toInt()),
//                       ),
//                     )
//                   ),
//                   Icon(
//                     Icons.verified_user,
//                     size: 100,
//                     color: rippleAnimation.value > 0.5 ? Colors.white : Colors.blue,
//                   )
//                 ],
//               ),
//             ),
//             Text('Scanning file...', style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ScanFile extends StatefulWidget {
  final FilePickerResult result;
  const ScanFile({super.key,required this.result});

  @override
  State<ScanFile> createState() => _FileScannedState();
}

class _FileScannedState extends State<ScanFile> with SingleTickerProviderStateMixin{
  late Animation rippleAnimation;
  late AnimationController animationController;
  var listRadius = [100.0,150.0,200.0,250.0,300.0];

  late String _scanStatus = 'Scanning files...';
  late bool _isScanning = true;
  bool _scanComplete = false;
  IconData _statusIcon = Icons.verified_user;
  Color _statusColor = Colors.blue;

  int _currentFileIndex = 0;
  int _totalFiles = 0;
  final List<String>  _fileResults = [];
  final List<bool> _scanResults = [];

  @override
  void initState() {
    super.initState();
    _totalFiles = widget.result.files.length;
    // animationController = AnimationController(vsync: this, duration: Duration(seconds: 3), lowerBound: 0.5);
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3),lowerBound: 0);
    rippleAnimation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationController.addListener((){
      setState(() {});
    });
    animationController.repeat(reverse: true);
    _startScan();
  }

  Future<void> _startScan() async {
    try {
      setState(() {
        _scanStatus = 'Analyzing $_totalFiles file${_totalFiles > 1 ? 's' : ''} for security threats...';
        _isScanning = true;
      });

      // bool isSafe = await _scanFile(widget.result);
      List<bool> results =  await _scanAllFiles(widget.result);
      if (!mounted) return;

      bool allFilesSafe = results.every((result) => result);
      int safeCount = results.where((result) => result).length;
      int unsafeCount = results.length - safeCount;

      if (allFilesSafe) {
        setState(() {
          _scanStatus = 'All $_totalFiles file${_totalFiles > 1 ? 's are' : ' is'} safe! ✓';
          _statusIcon = Icons.check_circle;
          _statusColor = Colors.green;
          _isScanning = false;
          _scanComplete = true;
        });

        animationController.stop();
        animationController.animateTo(1.0);

        await Future.delayed(Duration(milliseconds: 1500));

        if (mounted) {
          Navigator.pop(context, true);
        }
      } else {
        setState(() {
          // _scanStatus = 'Security threat detected!\nFile cannot be processed.';
          if (unsafeCount == _totalFiles) {
            _scanStatus = 'Security threats detected in all files!\nFiles cannot be processed.';
          } else {
            _scanStatus = 'Security threats detected in $unsafeCount file${unsafeCount > 1 ? 's' : ''}!\n$safeCount file${safeCount > 1 ? 's are' : ' is'} safe.';
          }
          _statusIcon = Icons.security;
          _statusColor = Colors.red;
          _isScanning = false;
          _scanComplete = true;
        });
        animationController.stop();
        animationController.animateTo(0.0);
        await Future.delayed(Duration(milliseconds: 2500));
        if (mounted) {
          Navigator.pop(context, false);
        }
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        // _scanStatus = 'Scan failed!\n${e.toString()}';
        _scanStatus = 'Scan failed!';
        _statusIcon = Icons.error;
        _statusColor = Colors.red;
        _isScanning = false;
        _scanComplete = true;
      });
      animationController.stop();
      animationController.animateTo(0.0);
      await Future.delayed(Duration(milliseconds: 2500));
      if (mounted) {
        Navigator.pop(context, false);
      }
    }
  }

  Future<List<bool>> _scanAllFiles(FilePickerResult result) async {
    List<bool> results = [];
    for (int i = 0; i < result.files.length; i++) {
      PlatformFile file = result.files[i];

      // Update progress
      setState(() {
        _currentFileIndex = i + 1;
        // _scanStatus = 'Scanning file $_currentFileIndex/$_totalFiles\n${file.name}';
        _scanStatus = 'Scanning file ($_currentFileIndex/$_totalFiles)';
      });
      
      try{
        bool isSafe = await _scanSingleFile(file);
        results.add(isSafe);
        _scanResults.add(isSafe);
        _fileResults.add('${file.name}: ${isSafe ? 'Safe' : 'Unsafe'}');
        
        print('File ${file.name} scan result: ${isSafe ? 'Safe' : 'Unsafe'}');
      }catch(e){
        print('Error scanning file.');
        results.add(false);
        _scanResults.add(false);
        _fileResults.add('${file.name}: Error');
      }

      if(i < result.files.length - 1){
        await Future.delayed(Duration(milliseconds: 300));
      }
    }

    return results;
  }

  Future<bool> _scanSingleFile(PlatformFile file) async {
    try{
      final url = Uri.parse('https://starial.store/app/v1/api/scan_file');
      final fileToScan = File(file.path!);
      final request = http.MultipartRequest('POST', url);
      request.files.add(
          await http.MultipartFile.fromPath('file',fileToScan.path)
      );
      // Need to add other fields when working properly like user id for adding the user details
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      print('Response Status: ${response.statusCode}');
      print('Response Body: $responseBody');

      if(response.statusCode == 200){
        print('File uploaded successfully!!');
        try {
          final data = jsonDecode(responseBody);
          return data['is_safe'] ?? true;
        } catch (e) {
          print('Error parsing response: $e');
          return false;
        }
      }else{
        print('Error while uploading file: ${response.statusCode}');
        return true;
      }
    }catch(e){
      print('Network error during scan: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if(_isScanning) ...listRadius.map((rad) => Container(
                    width: rad*rippleAnimation.value,height: rad*rippleAnimation.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withAlpha(((1 - rippleAnimation.value) * 255).toInt()),
                    ),
                  )
                  ),
                  if (_scanComplete)
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _statusColor.withOpacity(0.2),
                        // border: Border.all(
                        //   color: _statusColor,
                        //   width: 3,
                        // ),
                      ),
                    ),
                  Icon(
                    // Icons.verified_user,
                    _statusIcon,
                    size: 100,
                    // color: rippleAnimation.value > 0.5 ? Colors.white : Colors.blue,
                    color: _isScanning
                        ? (rippleAnimation.value > 0.5 ? Colors.white : _statusColor)
                        : _statusColor,
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                _scanStatus,
                style: TextStyle(
                  color: _scanComplete ? _statusColor : Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (_isScanning) ...[
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: _totalFiles > 0 ? _currentFileIndex / _totalFiles : 0,
                      valueColor: AlwaysStoppedAnimation<Color>(_statusColor),
                      backgroundColor: Colors.grey[300],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Progress: $_currentFileIndex/$_totalFiles files',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   width: 100,
              //   child: LinearProgressIndicator(
              //     valueColor: AlwaysStoppedAnimation<Color>(_statusColor),
              //   ),
              // ),
              SizedBox(height: 10),
              Text(
                'Please wait...',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
            if (_scanComplete && _fileResults.isNotEmpty) ...[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Container(
                  constraints: BoxConstraints(maxHeight: 150),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Text(
                        //   'Scan Results:',
                        //   style: TextStyle(
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.bold,
                        //     color: Colors.grey[700],
                        //   ),
                        // ),
                        SizedBox(height: 10),
                        ..._fileResults.take(5).map((result) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Text(
                            result,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                        if (_fileResults.length > 5)
                          Text(
                            '... and ${_fileResults.length - 5} more files',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            // Text('Scanning file...', style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

}

