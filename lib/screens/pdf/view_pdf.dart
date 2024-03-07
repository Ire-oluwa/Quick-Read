import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quick_read/constants/colours.dart';
import 'package:quick_read/screens/pdf/load_pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatelessWidget {
  PdfView({super.key, required this.pdfUrl});

  final String pdfUrl;
  final PdfViewerController _viewerController = PdfViewerController();

  @override
  Widget build(BuildContext context) {
    final prov = Get.put(PdfController());
    return Scaffold(
      backgroundColor: kPrimaryWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
          child: SafeArea(
            child: Obx(
              () => prov.isLoading.value
                  ? Center(
                      child: SizedBox(
                        height: 50.h,
                        width: 50.r,
                        child: CircularProgressIndicator(
                          color: kPrimaryBlack,
                          strokeWidth: 3.r,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: FutureBuilder<String>(
                        future: prov.downloadPdf(pdfUrl),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SfPdfViewer.network(
                              snapshot.data!,
                              canShowPaginationDialog: true,
                              controller: _viewerController,
                            );
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
