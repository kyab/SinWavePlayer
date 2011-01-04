# Controller.rb
# AiffPlayer
#
# Created by koji on 10/12/17.
# Copyright 2010 __MyCompanyName__. All rights reserved.

framework "CoreAudio"

class Controller
	attr_accessor :label_freq,:slider_freq
	def awakeFromNib()
		NSLog("Controller.rb awaked from nib")
		NSLog("Running on MacRuby " + MACRUBY_VERSION)
		
		@auProcessor = AUProcessor.new
		#NSApp.delegate = self
		puts "#{NSApp.delegate }"
	end
	
	def hello(sender)
		puts "Controller#hello"
	end
	
	def initCoreAudio(sender)
		@auProcessor.initCoreAudio
	
	end
	
	def start(sender)
		@auProcessor.start
	end
	
	def stop(sender)
		#puts "Controller.stop"
		@auProcessor.stop
	end
	
	
	def listOutputDevices(sender)
		@auProcessor.listOutputDevices
	end
	
	def listOutputDevices_ruby(sender)
		pSize = Pointer.new("I");
		r = AudioHardwareGetPropertyInfo(KAudioHardwarePropertyDevices, pSize, nil)
		puts pSize[0]
		
		count = pSize[0] / 4 #is there any way to do sizeof(type??)
		pDeviceIDs = Pointer.new("I", count)
		
		r = AudioHardwareGetProperty(KAudioHardwarePropertyDevices, pSize, pDeviceIDs)
		
		deviceIDs = Array.new
		count.times do |i|
			deviceIDs << pDeviceIDs[i]
		end
		#AudioStreamRangedDescription
	
		deviceIDs.each do |devID|
			pName = Pointer.new("c",256)
			pSize = Pointer.new("I")
			pSize.assign(256)
			#p devID
			
			#AudioStreamBasicDescriptions
			
			r = AudioDeviceGetProperty(devID,0,0,KAudioDevicePropertyDeviceName, pSize,pName)
			#p pSize[0]
			name = String.new
			(pSize[0]-1).times do |n|	#NULL文字も入ってくるので -1。
				name << pName[n]
			end
			puts "device - id:#{devID} name:#{name}"
		end
		
		
		#kAudioStreamPropertyAvailableVirtualFormats
	end
	
	#freq slider handler (should use Cocoa-Bind)
	def freq_slider_changed(sender)
		@label_freq.stringValue = sender.intValue().to_s
		@auProcessor.setFreq(sender.intValue)
	end
	
	#delegation method
	def applicationShouldTerminateAfterLastWindowClosed(sender)
		puts "last window closed"
		return true
	end
end
	