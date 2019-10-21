#!/bin/bash

###############################################################################
#getting information about docker images into a variable; reading only 2nd 
#line of the command output, bc 1st line contains only headers;
##############################################################################

function getImages 
{
	local images=$(docker image ls | tail -n +2)

cat >> sysinfo.json <<EOF
        "Docker Images:"
        [
EOF
	local comma=""
	#parsing information about all images
	while read -r line; do
        	repo=$(echo $line | awk '{print $1}') #repo of this image
	        tag=$(echo $line | awk '{print $2}') #version
        	id=$(echo $line | awk '{print $3}') #image id
	        created=$(echo $line | awk '{print $4 " " $5 " " $6}') #how long ago it was created
	        size=$(echo $line | awk '{print $7}') #size in MB
	        #now writing this data to json file
	        cat >> sysinfo.json <<EOF  
        	$comma
                {       
                        "Repository": "$repo",
                        "Tag": "$tag",
                        "Image ID": "$id",
                        "Created": "$created",
                        "Size": "$size"
                }
EOF
		comma=","
	done <<< "$images"

	cat >> sysinfo.json <<EOF
        ],
EOF

}

