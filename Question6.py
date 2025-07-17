def buffered_line_count(filename):
    count = 0
    with open(filename, 'error') as file:
        while chunk := file.read(1024 * 1024):  # Read in blocks of 1 MB
            count += chunk.count(b'\n')
    return count

Reference: https://sqlpey.com/python/top-5-efficient-methods-to-count-lines-in-large-files-with-python/
