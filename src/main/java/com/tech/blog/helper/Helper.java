package com.tech.blog.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class Helper {

	// deleting profile pic code
	public static boolean deleteProfile(String path) {
		boolean f = false;
		try {

			File file = new File(path);
			f = file.delete();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	// updating profile pic code
	public static boolean saveProfile(InputStream is, String path) {
		boolean f = false;
		try {
			byte[] data = new byte[is.available()];
			is.read(data);

			FileOutputStream fos = new FileOutputStream(path);
			fos.write(data);
			fos.flush();
			fos.close();
			f = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

}
