/// Hidden column storing each row's original position in the DBC file.
///
/// The import worker writes the DBC record index into this column and the
/// export workers order by it, so order-sensitive DBCs round-trip
/// unchanged. Talent.dbc is the prime example: the 3.3.5 client derives
/// the whole talent-tree layout from the file row order (each tab's rows
/// must stay contiguous and grid positions are implicit in the within-tab
/// order), so re-exporting rows sorted by ID scrambles every tree.
///
/// The column is never part of a DBC schema: the export writer ignores it,
/// and rows created through the app (generated repositories) leave it
/// NULL, which orders them after the imported rows on export.
const String dbcRowOrderColumn = '__dbc_order';
