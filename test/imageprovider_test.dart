import 'package:camera/camera.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecotags/providers/image/ImageProvider.dart';
void main() {
  group('ImageProvider', () {
    test('addImage should add an image to the list', () {
      final provider = ImageProvider();
      final image = XFile('https://lh3.googleusercontent.com/proxy/Ck5mAJcvh0hmIgEfrwtt0kQftFeKp0bmtbDcwjpa3nN7Zrk3rdzPITaYpGLqAOY-ptw98Nb02Yf2l--SEN4C06M0siUW-AwQCAzwBRadSAxqjMwjTcosn4gXkG15m5H2L3PU_wfakB4FjC6_eRNzYKWqRkNWIZ5Cdp00Rn0=w3840-h2160-p-k-no-nd-mv');

      provider.addImage(image);

      expect(provider.images, [image]);
    });

    test('removeImage should remove an image from the list', () {
      final provider = ImageProvider();
      final image = XFile('https://lh3.googleusercontent.com/proxy/Ck5mAJcvh0hmIgEfrwtt0kQftFeKp0bmtbDcwjpa3nN7Zrk3rdzPITaYpGLqAOY-ptw98Nb02Yf2l--SEN4C06M0siUW-AwQCAzwBRadSAxqjMwjTcosn4gXkG15m5H2L3PU_wfakB4FjC6_eRNzYKWqRkNWIZ5Cdp00Rn0=w3840-h2160-p-k-no-nd-mv');
      provider.addImage(image);

      provider.removeImage(image);

      expect(provider.images, []);
    });

    test('clearImages should remove all images from the list', () {
      final provider = ImageProvider();
      final image1 = XFile('https://lh3.googleusercontent.com/proxy/Ck5mAJcvh0hmIgEfrwtt0kQftFeKp0bmtbDcwjpa3nN7Zrk3rdzPITaYpGLqAOY-ptw98Nb02Yf2l--SEN4C06M0siUW-AwQCAzwBRadSAxqjMwjTcosn4gXkG15m5H2L3PU_wfakB4FjC6_eRNzYKWqRkNWIZ5Cdp00Rn0=w3840-h2160-p-k-no-nd-mv');
      final image2 = XFile('https://lh3.googleusercontent.com/proxy/Ck5mAJcvh0hmIgEfrwtt0kQftFeKp0bmtbDcwjpa3nN7Zrk3rdzPITaYpGLqAOY-ptw98Nb02Yf2l--SEN4C06M0siUW-AwQCAzwBRadSAxqjMwjTcosn4gXkG15m5H2L3PU_wfakB4FjC6_eRNzYKWqRkNWIZ5Cdp00Rn0=w3840-h2160-p-k-no-nd-mv');
      provider.addImage(image1);
      provider.addImage(image2);

      provider.clearImages();

      expect(provider.images, []);
    });
  });
}