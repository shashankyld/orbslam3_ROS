# ORB-SLAM3 
### [Link to original ORB-SLAM3's README.md](https://github.com/UZ-SLAMLab/ORB_SLAM3)


## This repo works well with Ubuntu 20, ROS Noetic, Docker 

### Building Docker Image 

0. Clone this repo
```
https://github.com/shashankyld/orbslam3_ROS.git
```

1. Build the docker file located in this "orbslam3_ROS/docker_orbslam_shashank/" directory
```
# Change tag to your choice
docker build -t noetic-orbslam3:v3.0  orbslam3_ROS/docker_orbslam_shashank/

```
2. Create a contianer 
```
# Change the "-v" tag to mount your local dataset file(directory where you downloaded your data set) on the docker container at a location of choice
docker run --privileged -v /home/shashank/Documents/photogrammetrylab/Docker_Containers/realsense_container/launch_from_host:/opt/ros/noetic/share/realsense2_camera/launch/from_host/ -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix noetic-orbslam3:v3.0
```
```
#WITH NETWORK TAG
docker run --network ipb --privileged -v /home/shashank/Documents/photogrammetrylab/Docker_Containers/realsense_container/launch_from_host:/opt/ros/noetic/share/realsense2_camera/launch/from_host/ -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix noetic-orbslam3:v3.0
```

### Building ORBSLAM3 and ORBSLAM3 ROS workspace
3. Build ORBSLAM3 
```
# The build.sh script automates the process of configuring and building ORB_SLAM3 and its required third-party libraries.
cd /dpds/ORB_SLAM3 && ./build.sh
```

4. Build orbslam3 ros workspace
```
# This command executes the script to build and set up the ORB_SLAM3 ROS workspace.
./build_ros_orbslam3.sh
```
```
# Source ROS workspace
source orbslam3_ws/devel/setup.bash
```
### Interacting with docker
5. Create multiple interactive shells to the docker container
```
docker exec -it <container_name> bash
```
6. Run this following on your local bash to access GUI using X11
```
xhost + 
```


### Running ROS examples

7. Download any ROS bag file from [The EuRoC MAV Dataset](https://projects.asl.ethz.ch/datasets/doku.php?id=kmavvisualinertialdatasets) to your local machine
8. Run your bag file after following step 5 and 6
``` 
# rosbag play -l <your_bag_file>

# Example for euroc data set (Machine Hall 01)
# cd to mounted directory
rosbag play -l MH_01_easy.bag
```
9. Source your ros workspace
10. Run the ros launch file for "euroc_monoimu"
```
roslaunch orb_slam3_ros_wrapper euroc_monoimu.launch
```

## Notes:
### This repo is based on the works of "thien94" [Link to original Orbslam3 ROS workspace](https://github.com/thien94/orb_slam3_ros_wrapper)

A. Works with Ubuntu 20.04, and docker, no additional work is required.

B. You will have to modify the launch file to consider for changes in ros topic names

C. Building ROS workspace failed on my PC whenever I had multiple apps running parallelly, I just close the other apps to fix this. (Internet stops working suddenly during this build, why?)

