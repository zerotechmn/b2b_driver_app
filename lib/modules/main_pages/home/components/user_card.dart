import 'package:b2b_driver_app/data/models/card_model.dart';
import 'package:b2b_driver_app/modules/main_pages/home/controller.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    getQrCode({bool isDialog = false}) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;

      // Check if the screen is in landscape mode
      final isLandscape = screenWidth > screenHeight;
      double maxDialogSize = 500;
      double dialogSize = isLandscape ? screenHeight - 64 : screenWidth - 64;
      if (dialogSize > maxDialogSize) {
        dialogSize = maxDialogSize;
      }

      return Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: isDialog ? dialogSize : 110,
            maxHeight: isDialog ? dialogSize : 110,
          ),
          decoration: BoxDecoration(
            color: colors(context).backgroundPrimary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: GetBuilder<HomeController>(
            builder: (controller) {
              final qrCode = controller.getQR();
              if (qrCode == null || controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    color: colors(context).primary,
                  ),
                );
              }
              return PrettyQrView(
                qrImage: controller.getQR(),
                decoration: PrettyQrDecoration(
                  shape: PrettyQrSmoothSymbol(
                    color: isDialog ? Color(0xFF000000) : Color(0xFFd54d3f),
                    roundFactor: 1,
                  ),
                  quietZone: const PrettyQrModulesQuietZone(3),
                ),
              );
            },
          ),
        ),
      );
    }

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 145,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: CustomPaint(painter: VerticalCurvePainter()),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: GetBuilder<HomeController>(
                  builder: (controller) {
                    bool isLoading = controller.isLoading.value;
                    CardModel? card = controller.cardDetail.value;
                    return Skeletonizer(
                      enabled: isLoading,
                      child: Column(
                        spacing: 4,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Картын үлдэгдэл",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme(context).bodyMedium!.copyWith(
                              color: colors(context).backgroundPrimary,
                            ),
                          ),
                          Text(
                            (card?.balance ?? 0).toInt().toCurrency(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme(context).headlineLarge!.copyWith(
                              color: colors(context).backgroundPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Картын дугаар",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme(context).bodyMedium!.copyWith(
                              color: colors(context).backgroundPrimary,
                            ),
                          ),
                          Text(
                            (card?.cardNumber ?? "0000 0000 0000 0000"),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme(context).titleMedium!.copyWith(
                              color: colors(context).backgroundPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.dialog(
                    getQrCode(isDialog: true),
                    barrierDismissible: true,
                  );
                },
                child: getQrCode(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class VerticalCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Define gradient for the left curved side
    final leftGradient = LinearGradient(
      colors: [Color(0xFFFFB80F), Color(0xFFC01656)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    // Define gradient for the right side
    final rightGradient = LinearGradient(
      colors: [Color(0xFFe5742d), Color(0xFFca2f4c)],
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      stops: [0, 0.6],
    );

    final rightPaint =
        Paint()
          ..shader = rightGradient.createShader(
            Rect.fromLTWH(0, 0, size.width, size.height),
          );

    final leftPaint =
        Paint()
          ..shader = leftGradient.createShader(
            Rect.fromLTWH(0, 0, size.width, size.height),
          );

    // Draw left background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), rightPaint);

    // Draw curved left portion
    final path = Path();

    // Start from top left
    path.moveTo(0, 0);
    // Go to top-right before the curve
    path.lineTo(size.width * 0.55, 0);
    // Add a big vertical arc (like a circle on the right)
    path.quadraticBezierTo(
      size.width * 0.38, // control point x (way outside right)
      size.height / 2.7, // control point y (middle)
      size.width * 0.4, // end x
      size.height, // end y
    );
    // Complete the path to bottom-left
    path.lineTo(0, size.height);
    path.close();

    // Draw the path with left paint
    canvas.drawPath(path, leftPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
