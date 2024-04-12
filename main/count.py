import os
folder_main = "/ssd_scratch/cvit/aparna/SMPLer-X/demo/ASL/results"
count = 0
remained =0
for folder in os.listdir(folder_main):
    print(folder)

    for folder1 in os.listdir(os.path.join(folder_main, folder)):
        try:
            x=  os.listdir(os.path.join(folder_main,folder, folder1))
        except:
            print(count)
            continue
        print(x,"x")
        if "smplx" in x:
            count += 1
        else:
            remained +=1
print(count)
print(remained)
