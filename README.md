# ORB-SLAM3 
### [Link to original ORB-SLAM3's README.md](https://github.com/UZ-SLAMLab/ORB_SLAM3)


## This repo works well with Ubuntu 20, ROS Noetic, Docker 

### Building Docker Image 

1. Build the docker file located in this orbslam3_ROS/docker_orbslam_shashank/ directory
```
# Change tag to your choice
docker build -t noetic-orbslam3:v3.0  orbslam3_ROS/docker_orbslam_shashank/

```
2. Create a contianer 
```
# Change the "-v" tag to mount your local dataset file on the docker container
docker run --privileged -v /home/shashank/Documents/photogrammetrylab/Docker_Containers/realsense_container/launch_from_host:/opt/ros/noetic/share/realsense2_camera/launch/from_host/ -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix noetic-orbslam3:v3.0
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

### Interacting with docker
5. Create multiple interactive shells to the docker container
```
docker exec -it <container_name> bash
```


# Run in mono-inertial mode
./Examples/Monocular-Inertial/mono_inertial_euroc ./Vocabulary/ORBvoc.txt ./Examples/Monocular-Inertial/EuRoC.yaml ~/Datasets/EuRoC/MH01 ./Examples/Monocular-Inertial/EuRoC_TimeStamps/MH01.txt dataset-MH01_monoimu

```
### Live with Realsense T265:
- The param file is located inside the folder with the same name as the example that you want to run (Mono/Mono-inertial/Stereo/Stereo-Inertial). The number of parameters that you need to modify  varies accordingly.

- Run `rs-enumerate-devices -c` to obtain the intrinsic & extrinsic parameters. A good instruction with pictures can be found [here](https://github.com/shanpenghui/ORB_SLAM3_Fixed#73-set-camera-intrinsic--extrinsic-parameters).

- If necessary, calibrate the T265's IMU intrinsic with [Kalibr](https://github.com/ethz-asl/kalibr) or [imu_utils](https://github.com/shanpenghui/imu_utils). The default params seem good enough for testing.


- Run:
```
./Examples/Monocular-Inertial/mono_inertial_realsense_t265 Vocabulary/ORBvoc.txt ./Examples/Monocular-Inertial/RealSense_T265.yaml 
```

## Changelog:
### 13-Aug-2022
Work with Ubuntu 20.04, no additional installation of OpenCV or C++ required:
- Update CMakeLists.txt to use OpenCV 4.2 mimimum.
- Update CMakeLists.txt to use C++14 instead of C++11.
