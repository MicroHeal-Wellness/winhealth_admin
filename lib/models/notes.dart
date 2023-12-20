class Note {
    String? dateTime;
    String? title;

    Note({
        this.dateTime,
        this.title,
    });

    factory Note.fromJson(Map<String, dynamic> json) => Note(
        dateTime: json["date_time"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "date_time": dateTime,
        "title": title,
    };
}