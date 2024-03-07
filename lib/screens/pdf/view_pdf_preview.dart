import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quick_read/constants/colours.dart';
import 'package:quick_read/routes/route_names.dart';
import 'package:quick_read/screens/pdf/load_pdf.dart';
import 'package:quick_read/screens/pdf/view_pdf.dart';

class PdfPreview extends StatelessWidget {
  const PdfPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Get.put(PdfController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PDFs",
          style: TextStyle(color: kPrimaryBlack),
        ),
      ),
      backgroundColor: kPrimaryWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
          child:
              Obx(() => (prov.isLoading.value) ? const Center(child: CircularProgressIndicator()) :
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                ),
                itemCount: prov.urls.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final pdfUrl = prov.urls[index];
                  final x = prov.urls[index];
                  return FutureBuilder<String>(
                    future: prov.downloadPdfPreview(pdfUrl),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (snapshot.hasData) {
                        final firstPageUrl = snapshot.data!;
                        final filename = extractFilename(pdfUrl);
                        return GestureDetector(
                          onTap: () {
                            log("This url was selected: $pdfUrl");
                            Future.delayed(const Duration(seconds: 2)).then((value) => Get.to(() {
                              return PdfView(pdfUrl: pdfUrl,);
                            }));
                          },
                          child: Card(
                            elevation: 2.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                firstPageUrl.isNotEmpty
                                    ? Image.network(pdfUrl)
                                    : const Text('No preview available'),
                                Text(filename),
                              ],
                            ),
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                },
              ),),
        ),
      ),
    );
  }

  String extractFilename(String pdfUrl) {
    // Extract filename from the full path (modify based on your path structure)
    return pdfUrl.split('/').last;
  }
}
