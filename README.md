
# josh5/libraryoptimise

### A simple container for optimising your library.
This container will monitor your video library using inotify. When a video is added that matches a configured list of extensions it will be processed. If the video is already the correct destination codec, it will be left alone. Otherwise it will be be re-encoded and replaced.

You can also specify a scheduled task to scan your entire library folder for files that need re-encoding. By default this will be carried out on start and every 60 mins afterwards.

This container uses ffmpeg, python schedule and pyinotify.

![LibraryOptimise (ffmpeg)](https://raw.githubusercontent.com/Josh5/docker-libraryoptimise/master/LibraryOptimise.png)

## Configuration:

Internally your media library is bound to /library/
Encoding cache is bound to /cache/

All conversion processes are run as the container's default user.
This can be modified with the PGID and PUID environment variables (see below)

Environment variables:

* `-e PGID` for setting the GroupID of the default user
* `-e PUID` for setting the UserID of the default user

    ### Library config
* `-e LIBRARY_PATH`                     Library location (default /library/)
* `-e CACHE_PATH`                       Encoder cache location (default /cache/)
* `-e SUPPORTED_CONTAINERS`             File extensions within the library path to monitor
    
    ### Video stream config
* `-e VIDEO_CODEC`                      Destination video codec (default hevc)

    ### Audio stream config. 

    Audio streams that are > 2 channels will be duplicated as stereo with these settings.

    Audio streams that are <= 2 channels will be converted with these settings
* `-e AUDIO_CODEC`                      Destination audio codec for stereo (defaut aac)
* `-e AUDIO_STEREO_STREAM_BITRATE`      Audio stream bitrate (default 128k)

    ### Video container config
* `-e OUT_CONTAINER`                    Destination container (default mkv)

    ### Remove subtitle streams from video
* `-e REMOVE_SUBTITLE_STREAMS`          (default True)

    ### Schedule full library scans ever X minutes
* `-e SCHEDULE_FULL_SCAN_MINS`          (default 60)

    ### Debugging
* `-e DEBUGGING`                        Enable debugging (default False)


