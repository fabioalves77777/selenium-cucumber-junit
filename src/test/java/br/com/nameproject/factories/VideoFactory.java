package br.com.nameproject.factories;
/*
import static org.monte.media.FormatKeys.EncodingKey;
import static org.monte.media.FormatKeys.FrameRateKey;
import static org.monte.media.FormatKeys.KeyFrameIntervalKey;
import static org.monte.media.FormatKeys.MIME_AVI;
import static org.monte.media.FormatKeys.MediaTypeKey;
import static org.monte.media.FormatKeys.MimeTypeKey;
import static org.monte.media.VideoFormatKeys.CompressorNameKey;
import static org.monte.media.VideoFormatKeys.DepthKey;
import static org.monte.media.VideoFormatKeys.ENCODING_AVI_TECHSMITH_SCREEN_CAPTURE;
import static org.monte.media.VideoFormatKeys.QualityKey;

import java.awt.GraphicsConfiguration;
import java.awt.GraphicsEnvironment;
import java.awt.Rectangle;
import java.awt.Toolkit;
import java.io.File;

import org.monte.media.Format;
import org.monte.media.FormatKeys.MediaType;
import org.monte.media.math.Rational;
import org.monte.screenrecorder.ScreenRecorder;

import br.com.nameproject.support.VideoHelper;

public class VideoFactory {

	public static final String USER_DIR = "user.dir";
    public static final String DOWNLOADED_FILES_FOLDER = "video";

    private ScreenRecorder screenRecorder;

    public void startRecording(String titleVideo) throws Exception {
        File file = new File(System.getProperty(USER_DIR) + File.separator + DOWNLOADED_FILES_FOLDER);
        int width = Toolkit.getDefaultToolkit().getScreenSize().width;
        int height = Toolkit.getDefaultToolkit().getScreenSize().height;
        Rectangle captureSize = new Rectangle(0, 0, width, height);
        GraphicsConfiguration gc = GraphicsEnvironment.getLocalGraphicsEnvironment().getDefaultScreenDevice().getDefaultConfiguration();
        this.screenRecorder = new VideoHelper(
        		gc, 
        		captureSize, 
        		new Format(
    				MediaTypeKey, 
    				MediaType.FILE, 
    				MimeTypeKey, 
    				MIME_AVI
				),
                new Format(
            		MediaTypeKey, 
            		MediaType.VIDEO, 
            		EncodingKey, 
            		ENCODING_AVI_TECHSMITH_SCREEN_CAPTURE, 
            		CompressorNameKey, 
            		ENCODING_AVI_TECHSMITH_SCREEN_CAPTURE, 
            		DepthKey, 
            		24, 
            		FrameRateKey,
                    Rational.valueOf(15), 
                    QualityKey, 
                    1.0f, 
                    KeyFrameIntervalKey, 
                    15 * 60
                ),
                new Format(
            		MediaTypeKey, 
            		MediaType.VIDEO, 
            		EncodingKey, 
            		"black", 
            		FrameRateKey, 
            		Rational.valueOf(30)), 
	                null, 
	                file, 
	                titleVideo
                );
        this.screenRecorder.start();
    }

    public void stopRecording() throws Exception {
        this.screenRecorder.stop();
    }
}
*/