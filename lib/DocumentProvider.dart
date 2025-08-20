import 'package:flutter/cupertino.dart';
import 'package:starial_app/print-document-model.dart';

class DocumentProvider with ChangeNotifier{
  final List<Document> _documents = [];
  List<Document> get documents => _documents;

  void addDocument(Document doc){
    _documents.add(doc);
    notifyListeners();
  }

  void deleteDocument(int id){
    _documents.removeWhere((doc) => doc.id == id);
    notifyListeners();
  }

  Document? getDocumentById(int id){
    try {
      return _documents.firstWhere((doc) => doc.id == id);
    } catch (e) {
      return null;
    }
  }

  void updateDocument(Document doc){
    final index = _documents.indexWhere((element) => element.id == doc.id);
    if(index != -1){
      _documents[index] = doc;
      notifyListeners();
    }
  }

  void incrementNoOfCopies(int id){
    final index = _documents.indexWhere((doc) => doc.id == id);
    if(index != -1){
      _documents[index] = _documents[index].copyWith(copies: _documents[index].copies + 1);
    }
    notifyListeners();
  }

  void decrementNoOfCopies(int id){
    final index = _documents.indexWhere((doc) => doc.id == id);
    if(index != -1){
      _documents[index] = _documents[index].copyWith(copies: _documents[index].copies - 1);
    }
    notifyListeners();
  }

  void clearDocuments() {
    _documents.clear();
    notifyListeners();
  }



}