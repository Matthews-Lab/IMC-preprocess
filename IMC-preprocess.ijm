img=newArray("add","image","names","here","without",".tiff");
for(j = 0; j < img.length; j++) {
	open("/path/to/images/"+ img[j] +".tiff");
selectImage(img[j] +".tiff");
run("Despeckle", "stack");

setBatchMode("hide");

// Add your own markers in the following loop
// Iterate over slices
for (i = 1; i <= nSlices; i++) {
    setSlice(i);
    if (i == 1) {
        // Set threshold for slice 1 (4G8)
        setAutoThreshold("Triangle");
    } else if (i == 2) {
        // Set threshold for slice 2 (HuCD)
        setAutoThreshold("Default");
    } else if (i == 3) {
        // Set threshold for slice 3 (CALB)
        setThreshold(0, 2);
    } else if (i == 4) {
        // Set threshold for slice 4 (PVALB)
        setThreshold(0, 1);
    } else if (i == 5) {
        // Set threshold for slice 5 (AT8)
        setAutoThreshold("Triangle");
    } else if (i == 6) {
        // Set threshold for slice 6 (RORB)
        setThreshold(0, 1);
    } else if (i == 7) {
        // Set threshold for slice 7 (SST)
        setAutoThreshold("RenyiEntropy");
    } else if (i == 8) {
        // Set threshold for slice 8 (CDH9)
        setThreshold(0, 2);
    } else if (i == 9) {
        // Set threshold for slice 9 (GAD1)
        setThreshold(0, 2);
    } else if (i == 10) {
        // Set threshold for slice 10 (RELN)
        setAutoThreshold("Triangle");
    } else if (i == 11) {
        // Set threshold for slice 11 (DNA)
        setAutoThreshold("Otsu");
    } else {
        // Set threshold to Otsu for other slices
        setAutoThreshold("Otsu");
    }

    // Create selection
    run("Create Selection");
    
    // Set pixels based on threshold
    if (selectionType() != -1) {
        run("Set...", "value=0");
    }

    // Clear selection
    run("Select None");
}

// Reset threshold
resetThreshold;

// Restore normal batch mode
setBatchMode("exit and display");

saveAs("Tiff", "/path/to/output/folder/" + img[j] + ".tiff");
run("Close All");
}
