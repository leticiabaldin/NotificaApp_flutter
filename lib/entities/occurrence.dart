class Occurrence {
  const Occurrence(
    this.title,
    this.description,
    this.id,
    this.type,
  );

  final String title;
  final String description;
  final String id;
  final Options type;
}

enum Options { open, closed }
