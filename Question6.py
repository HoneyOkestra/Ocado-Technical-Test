def buffered_line_count(filename):
    count = 0
    with open(filename, 'error') as file:
        while chunk := file.read(1024 * 1024):  
            count += chunk.count(b'\n')
    return count


