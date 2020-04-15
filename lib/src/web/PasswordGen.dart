import 'dart:math';

import 'PasswordAttributes.dart';

class NoPasswordBaseException implements Exception {
	@override
	String toString() {
		return 'Character pool for password generation cannot be empty';
	}
}

class IllegalLengthException implements Exception {
	@override
	String toString() {
		return 'Length should be at least the sum of the minimum restrictions';
	}
}

class PasswordGenerator {
	static Random _rand;
	static String upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	static String lower = "abcdefghijklmnopqrstuvwxyz";
	static String numbers = "0123456789";
	static String specials = "!@#\$%^&*()_+-=`~[]{}|;:,./<>?\\";

	static String generatePassword(PasswordAttributes attributes) {
		if (attributes.minSpecial + attributes.minNumbers > attributes.length)
			throw IllegalLengthException();

		String choice =
			(attributes.hasUpperCase ? upper : "") +
				(attributes.hasLowerCase ? lower : "") +
				(attributes.hasNumbers ? numbers : "") +
				(attributes.hasSpecialChars ? specials : "");

		if (choice == "")
			throw NoPasswordBaseException();

		_rand = new Random();

		List<String> pass = (' ' * attributes.length).split('');

		int length = attributes.length;

		if (attributes.hasNumbers)
			for (int i = 0; i < attributes.minNumbers; i++) {
				pass[_getNextIdx(pass)]  = numbers[_rand.nextInt(numbers.length)];
				length--;
			}

		if (attributes.hasSpecialChars)
			for (int i = 0; i < attributes.minSpecial; i++) {
				pass[_getNextIdx(pass)]  = specials[_rand.nextInt(specials.length)];
				length--;
			}

		for (int i = 0; i < length; i++) {
			pass[_getNextIdx(pass)]  = choice[_rand.nextInt(choice.length)];
		}

		return pass.join();
	}

	static int _getNextIdx(List<String> pass) {
		int idx;
		Random rand = Random();

		do {
			idx = rand.nextInt(pass.length);
		} while(pass[idx] != ' ');

		return idx;
	}
}
