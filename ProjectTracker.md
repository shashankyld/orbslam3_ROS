# Project Tracker

**TOPICS**

1. ROS in a Box (ROS pre-installed systemwide)
2. OrbSLAM3 Paper 

[GitHub - UZ-SLAMLab/ORB_SLAM3: ORB-SLAM3: An Accurate Open-Source Library for Visual, Visual-Inertial and Multi-Map SLAM](https://github.com/UZ-SLAMLab/ORB_SLAM3)

1. 

**TASKS**

1. Clone and study about Orb-slam 3 package.
2. Study about ROS tf package, and D435 sensor data and its constituents.
3. 

# PLAN

1. Use the script shared by Elias and other relevant packages to extract raw data from bag files.
    
    Expected Raw data: RGB image, Depth, Colored Depth data.
    
2. Install orb-slam 3, either based on ROS or direct package, use the point clouds to get the poses at each individual frame.
3. Embed pose data into images and point cloud frames data either as part of Metadata or whatever the rest of the pipeline dictates, for example an extra corresponding file/files containing all the transforms.
4. Figure out available 3D reconstructions methods and packages (Bundle Adjustment, COLMAP, …)
5. 

## REGARDING realsense:v1.0 image:

1. You may want to access the container interactively using multiple terminal session, in such case don’t forget to source the setup.bash using 
    
    ```bash
    source "/opt/ros/$ROS_DISTRO/setup.bash”
    ```
    
2. Useful command to start container with directory mount, x11 host

```bash
# /home/shashank/photogrammetrylab/Docker_Containers/realsense_container/launch_from_host
# /opt/ros/noetic/share/realsense2_camera/launch/from_host # HERE IF YOU MISS /from_host directory, it will delete existing files from launch folder in container.
docker run -v /home/shashank/photogrammetrylab/Docker_Containers/realsense_container/launch_from_host:/opt/ros/noetic/share/realsense2_camera/launch/from_host/ -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix realsense:v1.0
```

WITH PRIVILEGES

```bash
# /home/shashank/photogrammetrylab/Docker_Containers/realsense_container/launch_from_host
# /opt/ros/noetic/share/realsense2_camera/launch/from_host # HERE IF YOU MISS /from_host directory, it will delete existing files from launch folder in container.
docker run --privileged -v /home/shashank/photogrammetrylab/Docker_Containers/realsense_container/launch_from_host:/opt/ros/noetic/share/realsense2_camera/launch/from_host/ -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix realsense:v1.0
```

WITH NETWORKING BETWEEN HOST AND DOCKER WITHOUT PRIVILEGED (DIDN’T WORK FOR ME)

```bash
# /home/shashank/photogrammetrylab/Docker_Containers/realsense_container/launch_from_host
# /opt/ros/noetic/share/realsense2_camera/launch/from_host # HERE IF YOU MISS /from_host directory, it will delete existing files from launch folder in container.
docker run --network host -v /home/shashank/photogrammetrylab/Docker_Containers/realsense_container/launch_from_host:/opt/ros/noetic/share/realsense2_camera/launch/from_host/ -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix realsense:v1.0
```

2.1. We can also mount in reverse order like below, just by flipping the folders order (DIDN’T WORK FOR ME)

```bash
docker run -v /opt/ros/noetic/share/realsense2_camera/launch:/home/shashank/photogrammetrylab/Docker_Containers/realsense_container/launch_from_container -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix realsense:v1.0
```

2.2. Or one can do both (DID NOT WORK FOR ME)

```bash
docker run -v /home/shashank/photogrammetrylab/Docker_Containers/realsense_container/launch:/opt/ros/noetic/share/realsense2_camera/launch/from_host/ -v /opt/ros/noetic/share/realsense2_camera/launch/:/home/shashank/photogrammetrylab/Docker_Containers/realsense_container/launch_from_container -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix realsense:v1.0
```

1. CONNECT ROS OF DOCKER CONTAINER AND THE HOST: SO I CAN VIEW TOPICS THROUGH RVIZ ON HOST: WITH ROS_MASTER_URI (DIDN’T WORK FOR ME)

```jsx
export ROS_MASTER_URI=http://<host_ip>:11311 #IN DOCKER CONTAINER
```

```jsx
export ROS_IP=<host_ip> # IN HOST MACHINE
```

## Regarding noetic-orbslam3 docker image: v1.0

```bash
# /home/shashank/photogrammetrylab/Docker_Containers/realsense_container/launch_from_host
# /opt/ros/noetic/share/realsense2_camera/launch/from_host # HERE IF YOU MISS /from_host directory, it will delete existing files from launch folder in container.
docker run --privileged -v /home/shashank/Documents/photogrammetrylab/Docker_Containers/realsense_container/launch_from_host:/opt/ros/noetic/share/realsense2_camera/launch/from_host/ -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix noetic-orbslam3:v1.0
```

- I downloaded the EUROC data and shell scripts for euroc dataset from a different ORBSLAM3 github account: [https://github.com/shanpenghui/ORB_SLAM3_Fixed/tree/master/shells](https://github.com/shanpenghui/ORB_SLAM3_Fixed/tree/master/shells)

I was not able to run ROS examples of ORBSLAM3: 

```bash
#Command to copy file “euroc_examples.sh”  from “from_host” mount to “ORBSLAM3” folder.
cp -r /opt/ros/noetic/share/realsense2_camera/launch/from_host/shells/shells/euroc_examples.sh /dpds/ORB_SLAM3
```

To get ROS-ORBSLAM Running

1. Ran “build_ros.sh” which builds the ROS Package for ROS nodes

```bash
ROS NODES INCLUDE : AR ros_mono.cc ros_mono_inertial.cc ros_rgbd.cc ros_stereo.cc ros_stereo_inertial.cc
```

1. Make Errors arise and the build process is not successful

TRYING TO BUILD ROS EXAMPLES AGAIN

```bash
# Before building ORBSLAM3 OLD package using build_ros.sh script
# Actually I used a modified script from local host 
# called build_ros_old_orbslam3.sh
# Find it in realsense package in launch/from_host directory since all 
# the local files are hosted in this directory of the container
export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:/dpds/ORB_SLAM3/Examples/ROS
```

PREVIOUSLY TRIED BUILDING ROSORBSLAM3 from EXAMPLES DIRECTORY (DIDNT WORK)

> TRIED TO BUILD ROSORBSLAM3 PACKAGE FROM EXAMPLES_OLD (DIDN’T WORK)
> 

```bash
CMake Error at CMakeLists.txt:37 (message):
OpenCV > 2.4.3 not found.
```

MIT COURSE: EXERCISE RELEVANT

[https://vnav.mit.edu/labs/lab9/exercises.html#get-the-orb-slam3-docker-container](https://vnav.mit.edu/labs/lab9/exercises.html#get-the-orb-slam3-docker-container)

FOR ORBSLAM3 : ROS in UBUNTU 20, FOLLOWING REPO IS USEFUl

[https://github.com/thien94/ORB_SLAM3](https://github.com/thien94/ORB_SLAM3)

AND FOR THE ROS PACKAGE, USE THE FOLLOWING

[https://github.com/thien94/orb_slam3_ros_wrapper](https://github.com/thien94/orb_slam3_ros_wrapper)

**UPDATE ON USING “thien94” ORBSLAM3 git:**

1. I created a docker image by replacing Elias Marks with thien94’s repo. But, the example euroc data set doesn’t work properly, works witout GUI. But, continuing to work on ROS package using thien94 git repo : BELOW

[https://github.com/thien94/orb_slam3_ros_wrapper](https://github.com/thien94/orb_slam3_ros_wrapper)

```bash
NOTE: NEW DOCKER IMAGE “noetic-orbslam3:v2.1” by changing OpenCV 4.4 to 4.2 while installing opencv
```

![Untitled](Project%20Tracker%204088917ca2994b299bd102ed383bd105/Untitled.png)

This KannalaBrandt8 could be because of compiler crash! TRY CLOSING other programs 

**OTHER APPROACH: CONVERT THE BAG FILE INTO EUROC DATASET FORMAT**

Installed V2.1, V2.0 in the new os. install v1 and realsense packages

## VERSION: V3.0

This works perfectly alright:

[https://github.com/shashankyld/orbslam3_ROS](https://github.com/shashankyld/orbslam3_ROS)

Modify the README and try to make it run out of the box.

```bash
# /home/shashank/photogrammetrylab/Docker_Containers/realsense_container/launch_from_host
# /opt/ros/noetic/share/realsense2_camera/launch/from_host # HERE IF YOU MISS /from_host directory, it will delete existing files from launch folder in container.
docker run --privileged -v /home/shashank/Documents/photogrammetrylab/Docker_Containers/realsense_container/launch_from_host:/opt/ros/noetic/share/realsense2_camera/launch/from_host/ -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix noetic-orbslam3:v3.0
```

```bash
#Command to copy file “euroc_examples.sh”  from “from_host” mount to “ORBSLAM3” folder.
cp -r /opt/ros/noetic/share/realsense2_camera/launch/from_host/shells/shells/euroc_examples.sh /dpds/ORB_SLAM3
```

THINGS TO DO

1. Run [build.sh](http://build.sh) in the ORBSLAM directory

```jsx
# The build.sh script automates the process of configuring and building ORB_SLAM3 and its required third-party libraries
cd /dpds/ORB_SLAM3 && ./build.sh
```

1. Build orbslam3_ws 

```jsx
# This command executes the script to build and set up the ORB_SLAM3 ROS workspace.
./build_ros_orbslam3.sh
```

# ROS_ORBSLAM3 FINALLY WORKING

[https://github.com/shashankyld/orbslam3_ROS](https://github.com/shashankyld/orbslam3_ROS)

Today’s task:

1. Change the ORBSLAM3 topics to subscribe to side view instead of front
2. Record a bag file containing ORBSLAM topics as well
3. Use this bagpy python package to store the topic data in an excel format
