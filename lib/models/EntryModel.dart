class Entry {
  Entry(this.idEntry, this.title, [this.children = const <Entry>[]]);

  final int idEntry;
  final String title;
  final List<Entry> children;
}
