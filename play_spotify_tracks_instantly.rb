#!/usr/bin/env ruby

require 'file-tail'

played_songs = []
File.open("/srv/files/spotify/playlist.txt") do |log|
    log.extend(File::Tail)
    log.interval
    log.tail do |line|
        if not played_songs.include? line
            played_songs.push(line)
            `DISPLAY=":0.0" qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.OpenUri #{line}`
        end
    end
end

