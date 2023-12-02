path_to_dataset_directory = "Training_Dataset"; % insert name of (path to) the dir with dataset

saveToFile = haar_detect(path_to_dataset_directory);

save("Task_2_THUNDER_SPARROWS", "saveToFile");