class Document {
  final int id;
  final String title;
  final String orientation;
  final String colorPreference;
  final int pages;
  final String type;
  final int copies;
  final String filePath;
  final int totalCost;

  Document({
    required this.id,
    required this.title,
    required this.orientation,
    required this.colorPreference,
    required this.pages,
    required this.type,
    this.copies = 1,
    required this.filePath,
    required this.totalCost
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "orientation": orientation,
      "colorPreference": colorPreference,
      "pages": pages,
      "type": type,
      "copies": copies,
      "filePath": filePath,
      "totalCost":totalCost
    };
  }

  // Convert from JSON (for reading back)
  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json["id"],
      title: json["title"],
      orientation: json["orientation"],
      colorPreference: json['colorPreference'],
      pages: json["pages"],
      type: json["type"],
      copies: json['copies'],
      filePath: json["filePath"],
      totalCost: json['totalCost']
    );
  }

  Document copyWith({
    int? id,
    String? title,
    String? orientation,
    String? colorPreference,
    int? pages,
    String? type,
    int? copies,
    String? filePath,
    int? totalCost,
  }) {
    return Document(
      id: id ?? this.id,
      title: title ?? this.title,
      orientation: orientation ?? this.orientation,
      colorPreference: colorPreference ?? this.colorPreference,
      pages: pages ?? this.pages,
      type: type ?? this.type,
      copies: copies ?? this.copies,
      filePath: filePath ?? this.filePath,
      totalCost: totalCost ?? this.totalCost,
    );
  }
}
