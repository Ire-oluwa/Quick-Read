import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class PdfController extends GetxController {
  late String pdfUrl;
  late RxList<String> urls = <String>[].obs;
  final isLoading = true.obs;
  final FirebaseStorage storage = FirebaseStorage.instance;
  // late String tempDirRef;
  // late String tempFileRef;

  @override
  void onInit() {
    listAllDirectories();
    // downloadPdf();
    isLoading.value = false;
    log("The urls: $urls");
    update();
    log("All done!");
    super.onInit();
  }

  Future<void> listAllDirectories() async {
    try {
      ListResult result = await storage.ref().child("PDFs").listAll();
      urls.value = result.items.map((ref) => ref.fullPath).toList();
      log("The Urls are: $urls");
      isLoading.value = false;
      // for (var ref in result.items) {
      //   log('Found File: ${ref.fullPath.toString()}');
      //   tempFileRef = ref.fullPath.toString();
      // }
      // for (var ref in result.prefixes) {
      //   log("Found directory: $ref");
      //   tempDirRef = ref.fullPath.toString();
      // }
      Future.delayed(const Duration(seconds: 2), () {
        log("PDF URL $pdfUrl");
        update();
      });
    } catch (e) {
      final error = e.toString();
      log("Directory Error: $error");
    }
  }
  Future<String> downloadPdf(String pdfUrl) async {
    // final ref = storage.refFromURL(pdfUrl);
    String downloadUrl = await storage
        .ref()
        .child(pdfUrl)
        .getDownloadURL();
    log("Download URL: $downloadUrl");
    pdfUrl = downloadUrl;
    update();
    return downloadUrl;
    // SfPdfViewer.network(downloadUrl);
  }

  Future<String> downloadPdfPreview(String pdfUrl) async  {
    try{
      final ref = storage.refFromURL(pdfUrl);
      final metadata = await ref.getMetadata();
      final downloadUrl = await ref.getDownloadURL();
      final firstPageUrl = metadata.customMetadata?["firstPageUrl"];
      return downloadUrl;
    } catch(e){
      final error = e.toString();
      log("Error downloading first page preview for $pdfUrl: $error");
      return "";
    }
  }
}
