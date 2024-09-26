import 'package:dot_money_expense/app/constants/app_assets.dart';
import 'package:dot_money_expense/app/constants/app_colors.dart';

class CategoryItem {
  static Map<String, dynamic> category = {
    "makanan": {
      "icon_path": AppAssets.iconMakanan,
      "title": "Makanan",
      "color": AppColors.yellow
    },
    "internet": {
      "icon_path": AppAssets.iconInternet,
      "title": "Internet",
      "color": AppColors.blue3
    },
    "edukasi": {
      "icon_path": AppAssets.iconEdukasi,
      "title": "Edukasi",
      "color": AppColors.orange
    },
    "hadiah": {
      "icon_path": AppAssets.iconHadiah,
      "title": "Hadiah",
      "color": AppColors.red
    },
    "transportasi": {
      "icon_path": AppAssets.iconTranportasi,
      "title": "Transportasi",
      "color": AppColors.purple
    },
    "belanja": {
      "icon_path": AppAssets.iconBelanja,
      "title": "Belanja",
      "color": AppColors.green1
    },
    "alat_rumah": {
      "icon_path": AppAssets.iconBelanja,
      "title": "Alat Rumah",
      "color": AppColors.purple2
    },
    "olahraga": {
      "icon_path": AppAssets.iconOlahraga,
      "title": "Olahraga",
      "color": AppColors.blue2
    },
    "hiburan": {
      "icon_path": AppAssets.iconHiburan,
      "title": "Hiburan",
      "color": AppColors.blue1
    },
  };
}
