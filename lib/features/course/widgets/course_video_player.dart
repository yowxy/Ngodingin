import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class CourseVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const CourseVideoPlayer({super.key, required this.videoUrl});

  @override
  State<CourseVideoPlayer> createState() => _CourseVideoPlayerState();
}

class _CourseVideoPlayerState extends State<CourseVideoPlayer> {
  YoutubePlayerController? _youtubeController;
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  String? _currentVideoUrl;
  bool _isInitializing = false;
  bool _isYouTubeVideo = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    print("CourseVideoPlayer initState - Video URL: ${widget.videoUrl}");
    _initializeVideo(widget.videoUrl);
  }

  @override
  void didUpdateWidget(CourseVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    // PENTING: Deteksi perubahan video URL dan reinitialize
    if (oldWidget.videoUrl != widget.videoUrl) {
      print("Video URL changed from ${oldWidget.videoUrl} to ${widget.videoUrl}");
      _initializeVideo(widget.videoUrl);
    }
  }

  bool _isYouTubeUrl(String url) {
    return url.contains('youtube.com') || 
           url.contains('youtu.be') || 
           url.contains('m.youtube.com');
  }

  String? _extractYouTubeVideoId(String url) {
    // Extract video ID from various YouTube URL formats
    RegExp regExp = RegExp(
      r'(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/|youtube\.com\/v\/|m\.youtube\.com\/watch\?v=)([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
    );
    Match? match = regExp.firstMatch(url);
    return match?.group(1);
  }

  void _initializeVideo(String videoUrl) {
    // PENTING: Selalu reinitialize jika URL berbeda
    if (_currentVideoUrl == videoUrl && !_isInitializing) {
      print("Same video URL, skipping initialization");
      return;
    }

    print("Initializing video: $videoUrl");
    setState(() {
      _isInitializing = true;
      _isPlayerReady = false;
    });
    
    _currentVideoUrl = videoUrl;
    _isYouTubeVideo = _isYouTubeUrl(videoUrl);

    // Dispose controllers lama SEBELUM membuat yang baru
    _disposeControllers();

    if (_isYouTubeVideo) {
      _initializeYouTube(videoUrl);
    } else {
      _initializeRegularVideo(videoUrl);
    }
  }

  void _disposeControllers() {
    _youtubeController?.close();
    _youtubeController = null;
    
    _videoPlayerController?.dispose();
    _videoPlayerController = null;
    
    _chewieController?.dispose();
    _chewieController = null;
  }

  void _initializeYouTube(String videoUrl) {
    try {
      final videoId = _extractYouTubeVideoId(videoUrl);
      
      if (videoId != null) {
        print("Creating YouTube controller with video ID: $videoId");
        
        // Coba dengan parameter yang lebih aman
        _youtubeController = YoutubePlayerController(
          params: YoutubePlayerParams(
            showControls: true,
            mute: false,
            showFullscreenButton: true,
            loop: false,
            enableCaption: true,
            captionLanguage: 'id',
            showVideoAnnotations: false,
            enableJavaScript: true,
          ),
        );
        
        Future.delayed(const Duration(milliseconds: 500), () {
          if (_youtubeController != null && mounted) {
            _youtubeController!.loadVideoById(videoId: videoId);
          }
        });

        if (mounted) {
          setState(() {
            _isInitializing = false;
          });
        }
      } else {
        print("ERROR: Cannot extract video ID from URL: $videoUrl");
        if (mounted) {
          setState(() {
            _isInitializing = false;
          });
        }
      }
    } catch (error) {
      print("Error initializing YouTube video: $error");
      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
      }
    }
  }

  void _initializeRegularVideo(String videoUrl) {
    try {
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
        ..initialize().then((_) {
          if (mounted) {
            _videoPlayerController!.setVolume(1.0);
            
            _chewieController = ChewieController(
              videoPlayerController: _videoPlayerController!,
              autoPlay: false,
              looping: false,
              allowFullScreen: true,
              allowMuting: true,
              materialProgressColors: ChewieProgressColors(
                playedColor: Colors.green,
                handleColor: Colors.green,
                backgroundColor: Colors.grey.shade300,
                bufferedColor: Colors.lightGreen,
              ),
              placeholder: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.green.shade200,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
              errorBuilder: (context, errorMessage) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.red.shade200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, color: Colors.white, size: 48),
                        const SizedBox(height: 10),
                        Text(
                          "Error: $errorMessage",
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
            
            setState(() {
              _isInitializing = false;
              _isPlayerReady = true;
            });
          }
        }).catchError((error) {
          print("Error initializing regular video: $error");
          if (mounted) {
            setState(() {
              _isInitializing = false;
            });
          }
        });
    } catch (error) {
      print("Error creating video controller: $error");
      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
      }
    }
  }

  @override
  void dispose() {
    print("CourseVideoPlayer disposing");
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("CourseVideoPlayer build - isInitializing: $_isInitializing, isYouTube: $_isYouTubeVideo, isReady: $_isPlayerReady, URL: ${widget.videoUrl}");
    
    if (_isInitializing) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.green.shade200,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 10),
              Text(
                "Loading video...",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }

    if (_isYouTubeVideo) {
      if (_youtubeController == null) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red.shade200,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.white, size: 48),
                SizedBox(height: 10),
                Text(
                  "Error loading YouTube video",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }

      // PERBAIKI: Gunakan YoutubePlayer langsung tanpa Scaffold untuk menghindari memory issues
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: YoutubePlayer(
            controller: _youtubeController!,
            aspectRatio: 16 / 9,
          ),
        ),
      );
    } else {
      // Regular video player untuk VPS
      if (_chewieController == null || !_videoPlayerController!.value.isInitialized) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red.shade200,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.white, size: 48),
                SizedBox(height: 10),
                Text(
                  "Error loading video",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  "Video may be too large or server is slow",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }

      return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Chewie(controller: _chewieController!),
        ),
      );
    }
  }
}