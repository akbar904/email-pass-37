
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_flutter_app/models/user.dart';

void main() {
	group('User Model', () {
		group('Serialization', () {
			test('correctly serializes from JSON', () {
				// Arrange
				final json = {'email': 'test@example.com'};
				
				// Act
				final user = User.fromJson(json);
				
				// Assert
				expect(user.email, 'test@example.com');
			});
			
			test('correctly serializes to JSON', () {
				// Arrange
				final user = User(email: 'test@example.com');
				
				// Act
				final json = user.toJson();
				
				// Assert
				expect(json, {'email': 'test@example.com'});
			});
		});
		
		group('Constructor', () {
			test('correctly initializes email field', () {
				// Act
				final user = User(email: 'test@example.com');
				
				// Assert
				expect(user.email, 'test@example.com');
			});
		});
	});
}
