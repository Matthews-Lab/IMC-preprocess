// This macro should be used as a framework to preprocess images.
// Change the thresholding methods depending on what works best.
// I have provided an example where sequential thresholding works well.
// If this is not necessary, remove the later for loops.

path=getDirectory("/Volumes/sb3222/home/Exp1/img/");
print(path)
// Get the list of files in the current directory
img = getFileList(path);

for(j = 0; j < img.length; j++) {
	open(path + img[j]);
selectImage(img[j]);
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
        setAutoThreshold("Moments");
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

// Despeckle Certain Slices
for (i = 1; i <= nSlices; i++) {
    setSlice(i);
    if (i == 2) {
    	run("Despeckle", "slice");
    } else if (i == 3) {
    	run("Despeckle", "slice");
    } else if (i == 6) {
    	run("Despeckle", "slice");
    } else if (i == 8) {
    	run("Despeckle", "slice");
    } else if (i == 10) {
    	run("Despeckle", "slice");
    }
}

// Further thresholding CALB, PVALB and GAD1
for (i = 1; i <= nSlices; i++) {
    setSlice(i);
    if (i == 3) {
    	setAutoThreshold("RenyiEntropy");
    run("Create Selection");
    if (selectionType() != -1) {
        run("Set...", "value=0");
    }
    } else if (i == 4) {
    	setAutoThreshold("RenyiEntropy");
    	// Create selection
    run("Create Selection");
     if (selectionType() != -1) {
        run("Set...", "value=0");
    }
    } else if (i == 9) {
    	setAutoThreshold("Moments");
    	// Create selection
    run("Create Selection");
     if (selectionType() != -1) {
        run("Set...", "value=0");
    }
    }
    
    // Clear selection
    run("Select None");
}


saveAs("Tiff", "/Volumes/sb3222/home/Exp1/processed_img/" + img[j]);
run("Close All");
}
