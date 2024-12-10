# open file for reading
set fh [open rtl.txt r+]
set file_data [read $fh]

# open file for writing
set fh2 [open my_file.txt w+]

set designs {Async_fifo.v \
				DF_Sync.v \
				fifo_mem.v \ 
				fifo_rd.v \
				fifo_wr.v \
				Int_ClkDiv.v \
				enable_sync.v}
puts "\\{$designs\\}"

puts $fh2 $file_data

close $fh 
close $fh2


