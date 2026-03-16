import csv

file_path = "/Users/janiceivana/Project/sql/apple_global_sales_dataset.csv"

non_ascii_rows = []

with open(file_path, newline="", encoding="utf-8") as csvfile:
    reader = csv.reader(csvfile)
    headers = next(reader)  # skip header
    for i, row in enumerate(reader, start=2):  # start=2 because header is row 1
        for cell in row:
            if any(ord(c) > 127 for c in cell):
                non_ascii_rows.append((i, row))
                break  # stop at first non-ASCII cell in the row

# Report
print(f"Total rows with non-ASCII characters: {len(non_ascii_rows)}\n")
for row_num, row in non_ascii_rows[:10]:  # print first 10 rows
    print(f"Row {row_num}: {row}")
