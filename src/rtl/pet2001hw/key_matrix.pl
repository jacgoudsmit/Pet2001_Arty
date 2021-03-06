#!/usr/bin/perl
#


# (PET) Key matrix --> ASCII (we need to reverse this)
#
@petmatrix = (
# col 7    6     5     4     3     2     1     0 
    0x1d, 0x13, 0x5f, 0x28, 0x26, 0x25, 0x23, 0x21,	# row 0
    0x08, 0x11, 0xff, 0x29, 0x5c, 0x27, 0x24, 0x22,	# row 1
    0x39, 0x37, 0x5e, 0x4f, 0x55, 0x54, 0x45, 0x51,	# row 2
    0x2f, 0x38, 0xff, 0x50, 0x49, 0x59, 0x52, 0x57,	# row 3
    0x36, 0x34, 0xff, 0x4c, 0x4a, 0x47, 0x44, 0x41,	# row 4
    0x2a, 0x35, 0xff, 0x3a, 0x4b, 0x48, 0x46, 0x53,	# row 5
    0x33, 0x31, 0x0d, 0x3b, 0x4d, 0x42, 0x43, 0x5a,	# row 6
    0x2b, 0x32, 0xff, 0x3f, 0x2c, 0x4e, 0x56, 0x58,	# row 7
    0x2d, 0x30, 0xff, 0x3e, 0xff, 0x5d, 0x40, 0x04,	# row 8
    0x3d, 0x2e, 0xff, 0x03, 0x3c, 0x20, 0x5b, 0x12	# row 9
    );

#
# Next, create ASCII to Commodore keyboard matrix
#
for ($i = 0; $i < 256; $i++) {
    $ascii_to_pet_row[$i] = -1;
    $ascii_to_pet_col[$i] = -1;
}

for ($i = 0; $i <= $#petmatrix ; $i++) {
    $col = 7 - ($i % 8);
    $row = $i / 8;
    $ascii = $petmatrix[$i];

    if ($ascii != 0xff) {
#	printf "row=%d col=%d ascii=0x%02x\n", $row, $col, $ascii;
	$ascii_to_pet_row[$ascii] = $row;
	$ascii_to_pet_col[$ascii] = $col;

        if ($ascii >= 0x41 && $ascii <= 0x5A) {
            # A-Z?  mark lower-case letter too
            $ascii_to_pet_row[$ascii + 0x20] = $row;
            $ascii_to_pet_col[$ascii + 0x20] = $col;
        }
    }
}

# Create Verilog case statement
for ($c = 0; $c < 256; $c++) {
    if ($ascii_to_pet_row[$c] != -1) {
        printf "\t8'h%02x: ascii_lookup = {4'd%d,4'd%d}; // '%c'\n", $c,
	        $ascii_to_pet_row[$c], $ascii_to_pet_col[$c], $c;
    }
}
