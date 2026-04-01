enum UploadedBillSource { gallery, files, camera }

class UploadedBillModel {
  const UploadedBillModel({
    required this.id,
    required this.fileName,
    required this.fileSizeLabel,
    required this.source,
    required this.uploadedAt,
  });

  final String id;
  final String fileName;
  final String fileSizeLabel;
  final UploadedBillSource source;
  final DateTime uploadedAt;

  String get sourceLabel {
    switch (source) {
      case UploadedBillSource.gallery:
        return 'Gallery';
      case UploadedBillSource.files:
        return 'Files';
      case UploadedBillSource.camera:
        return 'Camera';
    }
  }
}
