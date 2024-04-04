package com.triennt.workcv.util;

import java.util.Random;

public class RandomCode {
	public static String getCode(int length) {
        // Độ dài của mã OTP
        int otpLength = length;

        // Kí tự sẽ được sử dụng để tạo mã OTP
        String numbers = "0123456789";

        // StringBuilder để xây dựng mã OTP
        StringBuilder otp = new StringBuilder(otpLength);

        // Tạo ngẫu nhiên mã OTP bằng cách chọn kí tự từ chuỗi numbers
        Random random = new Random();
        for (int i = 0; i < otpLength; i++) {
            int index = random.nextInt(numbers.length());
            char digit = numbers.charAt(index);
            otp.append(digit);
        }

        return otp.toString();
    }
}
