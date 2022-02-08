

import 'dart:convert';



class ProductCategoriesData {
  ProductCategoriesData({
    this.categories,
    this.recentSelectedCategories,
    this.mostRecentDrafts,
  });

  List<List<RecentSelectedCategory>>? categories;
  List<RecentSelectedCategory>? recentSelectedCategories;
  List<MostRecentDraft>? mostRecentDrafts;

  factory ProductCategoriesData.fromJson(Map<String, dynamic> json) => ProductCategoriesData(
    categories: List<List<RecentSelectedCategory>>.from(json["categories"].map((x) => List<RecentSelectedCategory>.from(x.map((x) => RecentSelectedCategory.fromJson(x))))),
    recentSelectedCategories: List<RecentSelectedCategory>.from(json["recent_selected_categories"].map((x) => RecentSelectedCategory.fromJson(x))),
    mostRecentDrafts: List<MostRecentDraft>.from(json["most_recent_drafts"].map((x) => MostRecentDraft.fromJson(x))),
  );


}

class RecentSelectedCategory {
  RecentSelectedCategory({
    this.productCategoryId,
    this.parentId,
    this.routeId,
    this.name,
    this.keywords,
    this.seoLink,
    this.description,
    this.shortDescription,
    this.stringCodeName,
    this.stringCodeDescription,
    this.stringCodeShortDescription,
    this.iconClass,
    this.hasAttributes,
    this.hasRoom,
    this.hasRating,
    this.whatOffered,
    this.images,
    this.level,
    this.sortOrder,
    this.isBrandRequired,
    this.isNameTranslated,
    this.suspended,
    this.deleted,
    this.enabled,
    this.addedById,
    this.addedByName,
    this.addedByIp,
    this.modifiedById,
    this.modifiedByName,
    this.modifiedByIp,
    this.nameTranslated,
    this.children,
    this.cultureCode,
  });

  String? productCategoryId;
  String? parentId;
  String? routeId;
  String? name;
  String? keywords;
  String? seoLink;
  String? description;
  String? shortDescription;
  String? stringCodeName;
  String? stringCodeDescription;
  String? stringCodeShortDescription;
  String? iconClass;
  String? hasAttributes;
  String? hasRoom;
  String? hasRating;
  String? whatOffered;
  String? images;
  String? level;
  String? sortOrder;
  String? isBrandRequired;
  String? isNameTranslated;
  String? suspended;
  String? deleted;
  String? enabled;
  String? addedById;
  String? addedByName;
  String? addedByIp;
  String? modifiedById;
  String? modifiedByName;
  String? modifiedByIp;
  String? nameTranslated;
  List<RecentSelectedCategory>? children;
  String? cultureCode;

  factory RecentSelectedCategory.fromJson(Map<String, dynamic> json) => RecentSelectedCategory(
    productCategoryId: json["product_category_id"],
    parentId: json["parent_id"],
    routeId: json["route_id"],
    name: json["name"],
    keywords: json["keywords"],
    seoLink: json["seo_link"],
    description: json["description"],
    shortDescription: json["short_description"],
    stringCodeName: json["string_code_name"],
    stringCodeDescription: json["string_code_description"],
    stringCodeShortDescription: json["string_code_short_description"],
    iconClass: json["icon_class"],
    hasAttributes: json["has_attributes"],
    hasRoom: json["has_room"],
    hasRating: json["has_rating"],
    whatOffered: json["what_offered"],
    images: json["images"],
    level: json["level"],
    sortOrder: json["sort_order"],
    isBrandRequired: json["is_brand_required"],
    isNameTranslated: json["is_name_translated"],
    suspended: json["suspended"],
    deleted: json["deleted"],
    enabled: json["enabled"],
    addedById: json["added_by_id"],
    addedByName: json["added_by_name"],
    addedByIp: json["added_by_ip"],
    modifiedById: json["modified_by_id"],
    modifiedByName: json["modified_by_name"],
    modifiedByIp: json["modified_by_ip"],
    nameTranslated: json["name_translated"],
    children: json["children"] == null ? null : List<RecentSelectedCategory>.from(json["children"].map((x) => RecentSelectedCategory.fromJson(x))),
    cultureCode: json["culture_code"] == null ? null : json["culture_code"],
  );

  Map<String, dynamic> toJson() => {
    "product_category_id": productCategoryId,
    "parent_id": parentId,
    "route_id": routeId,
    "name": name,
    "keywords": keywords,
    "seo_link": seoLink,
    "description": description,
    "short_description": shortDescription,
    "string_code_name": stringCodeName,
    "string_code_description": stringCodeDescription,
    "string_code_short_description": stringCodeShortDescription,
    "icon_class": iconClass,
    "has_attributes": hasAttributes,
    "has_room": hasRoom,
    "has_rating": hasRating,
    "what_offered": whatOffered,
    "images": images,
    "level": level,
    "sort_order": sortOrder,
    "is_brand_required": isBrandRequired,
    "is_name_translated": isNameTranslated,
    "suspended": suspended,
    "deleted": deleted,
    "enabled": enabled,
    "added_by_id": addedById,
    "added_by_name": addedByName,
    "added_by_ip": addedByIp,
    "modified_by_id": modifiedById,
    "modified_by_name": modifiedByName,
    "modified_by_ip": modifiedByIp,
    "name_translated": nameTranslated,
    "children": children == null ? null : List<dynamic>.from(children!.map((x) => x.toJson())),
    "culture_code": cultureCode == null ? null : cultureCode,
  };
}


class MostRecentDraft {
  MostRecentDraft({
    this.productId,
    this.clientUserId,
    this.expertUserId,
    this.productCategoryId,
    this.brandCategoryId,
    this.brandCategoryItemId,
    this.routeId,
    this.bidStartDate,
    this.bidEndDate,
    this.maxEstimatePrice,
    this.minEstimatePrice,
    this.isPickupRequired,
    this.isBuyRequired,
    this.isAuctionStatus,
    this.videoName,
    this.quantity,
    this.title,
    this.subtitle,
    this.name,
    this.description,
    this.shortDescription,
    this.messageExpert,
    this.isCompany,
    this.company,
    this.websiteUrl,
    this.contactName,
    this.cell,
    this.phone,
    this.fax,
    this.address1,
    this.address2,
    this.city,
    this.postCode,
    this.countryId,
    this.countryCode,
    this.country,
    this.zoneId,
    this.pickupZoneId,
    this.zone,
    this.zoneCode,
    this.latitude,
    this.longitude,
    this.isVatApplied,
    this.taxCategoryId,
    this.vatSettings,
    this.cityTaxSettings,
    this.cityTaxAmount,
    this.cityTaxType,
    this.cityTaxExcluded,
    this.invoiceRecipientName,
    this.invoiceCompanyName,
    this.isInvoiceRecipientSamePropertyAddress,
    this.invoiceCountryId,
    this.invoiceCityName,
    this.invoiceAddress,
    this.invoiceZipcode,
    this.isCertifiedLegality,
    this.isAcceptBox,
    this.isSecurityDepositRequired,
    this.isAdditionalChargeRequired,
    this.isShippingPromo,
    this.estimateRevenue,
    this.buyPrice,
    this.sortOrder,
    this.statusId,
    this.isProcessed,
    this.isDraft,
    this.isBidWon,
    this.isBidConfirmed,
    this.isPromoted,
    this.isBidable,
    this.isApproved,
    this.isModified,
    this.isSolr,
    this.suspended,
    this.deleted,
    this.enabled,
    this.addedById,
    this.addedByName,
    this.addedByIp,
    this.modifiedById,
    this.modifiedByName,
    this.modifiedByIp,
    this.categoryName,
    this.nameTranslated,
    this.image,
  });

  String? productId;
  String? clientUserId;
  String? expertUserId;
  String? productCategoryId;
  String? brandCategoryId;
  String? brandCategoryItemId;
  String? routeId;
  DateTime? bidStartDate;
  DateTime? bidEndDate;
  String? maxEstimatePrice;
  String? minEstimatePrice;
  int? isPickupRequired;
  int? isBuyRequired;
  int? isAuctionStatus;
  String? videoName;
  String? quantity;
  String? title;
  String? subtitle;
  String? name;
  String? description;
  String? shortDescription;
  String? messageExpert;
  String? isCompany;
  String? company;
  String? websiteUrl;
  String? contactName;
  String? cell;
  String? phone;
  String? fax;
  String? address1;
  String? address2;
  String? city;
  String? postCode;
  String? countryId;
  String? countryCode;
  String? country;
  String? zoneId;
  String? pickupZoneId;
  String? zone;
  String? zoneCode;
  String? latitude;
  String? longitude;
  String? isVatApplied;
  String? taxCategoryId;
  String? vatSettings;
  String? cityTaxSettings;
  String? cityTaxAmount;
  String? cityTaxType;
  String? cityTaxExcluded;
  String? invoiceRecipientName;
  String? invoiceCompanyName;
  String? isInvoiceRecipientSamePropertyAddress;
  String? invoiceCountryId;
  String? invoiceCityName;
  String? invoiceAddress;
  String? invoiceZipcode;
  String? isCertifiedLegality;
  String? isAcceptBox;
  String? isSecurityDepositRequired;
  String? isAdditionalChargeRequired;
  String? isShippingPromo;
  String? estimateRevenue;
  String? buyPrice;
  String? sortOrder;
  String? statusId;
  String? isProcessed;
  String? isDraft;
  String? isBidWon;
  String? isBidConfirmed;
  String? isPromoted;
  String? isBidable;
  String? isApproved;
  String? isModified;
  String? isSolr;
  String? suspended;
  String? deleted;
  String? enabled;
  String? addedById;
  String? addedByName;
  String? addedByIp;
  String? modifiedById;
  String? modifiedByName;
  String? modifiedByIp;
  String? categoryName;
  String? nameTranslated;
  bool? image;

  factory MostRecentDraft.fromJson(Map<String, dynamic> json) => MostRecentDraft(
    productId: json["product_id"],
    clientUserId: json["client_user_id"],
    expertUserId: json["expert_user_id"],
    productCategoryId: json["product_category_id"],
    brandCategoryId: json["brand_category_id"],
    brandCategoryItemId: json["brand_category_item_id"],
    routeId: json["route_id"],
    bidStartDate: DateTime.parse(json["bid_start_date"]),
    bidEndDate: DateTime.parse(json["bid_end_date"]),
    maxEstimatePrice: json["max_estimate_price"],
    minEstimatePrice: json["min_estimate_price"],
    isPickupRequired: json["is_pickup_required"],
    isBuyRequired: json["is_buy_required"],
    isAuctionStatus: json["is_auction_status"],
    videoName: json["video_name"],
    quantity: json["quantity"],
    title: json["title"],
    subtitle: json["subtitle"],
    name: json["name"],
    description: json["description"],
    shortDescription: json["short_description"],
    messageExpert: json["message_expert"],
    isCompany: json["is_company"],
    company: json["company"],
    websiteUrl: json["website_url"],
    contactName: json["contact_name"],
    cell: json["cell"],
    phone: json["phone"],
    fax: json["fax"],
    address1: json["address_1"],
    address2: json["address_2"],
    city: json["city"],
    postCode: json["post_code"],
    countryId: json["country_id"],
    countryCode: json["country_code"],
    country: json["country"],
    zoneId: json["zone_id"],
    pickupZoneId: json["pickup_zone_id"],
    zone: json["zone"],
    zoneCode: json["zone_code"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    isVatApplied: json["is_vat_applied"],
    taxCategoryId: json["tax_category_id"],
    vatSettings: json["vat_settings"],
    cityTaxSettings: json["city_tax_settings"],
    cityTaxAmount: json["city_tax_amount"],
    cityTaxType: json["city_tax_type"],
    cityTaxExcluded: json["city_tax_excluded"],
    invoiceRecipientName: json["invoice_recipient_name"],
    invoiceCompanyName: json["invoice_company_name"],
    isInvoiceRecipientSamePropertyAddress: json["is_invoice_recipient_same_property_address"],
    invoiceCountryId: json["invoice_country_id"],
    invoiceCityName: json["invoice_city_name"],
    invoiceAddress: json["invoice_address"],
    invoiceZipcode: json["invoice_zipcode"],
    isCertifiedLegality: json["is_certified_legality"],
    isAcceptBox: json["is_accept_box"],
    isSecurityDepositRequired: json["is_security_deposit_required"],
    isAdditionalChargeRequired: json["is_additional_charge_required"],
    isShippingPromo: json["is_shipping_promo"],
    estimateRevenue: json["estimate_revenue"],
    buyPrice: json["buy_price"],
    sortOrder: json["sort_order"],
    statusId: json["status_id"],
    isProcessed: json["is_processed"],
    isDraft: json["is_draft"],
    isBidWon: json["is_bid_won"],
    isBidConfirmed: json["is_bid_confirmed"],
    isPromoted: json["is_promoted"],
    isBidable: json["is_bidable"],
    isApproved: json["is_approved"],
    isModified: json["is_modified"],
    isSolr: json["is_solr"],
    suspended: json["suspended"],
    deleted: json["deleted"],
    enabled: json["enabled"],
    addedById: json["added_by_id"],
    addedByName: json["added_by_name"],
    addedByIp: json["added_by_ip"],
    modifiedById: json["modified_by_id"],
    modifiedByName: json["modified_by_name"],
    modifiedByIp: json["modified_by_ip"],
    categoryName: json["category_name"],
    nameTranslated: json["name_translated"],
    //image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "client_user_id": clientUserId,
    "expert_user_id": expertUserId,
    "product_category_id": productCategoryId,
    "brand_category_id": brandCategoryId,
    "brand_category_item_id": brandCategoryItemId,
    "route_id": routeId,
    "bid_start_date": bidStartDate!.toIso8601String(),
    "bid_end_date":bidEndDate!.toIso8601String(),
    "max_estimate_price": maxEstimatePrice,
    "min_estimate_price": minEstimatePrice,
    "is_pickup_required": isPickupRequired,
    "is_buy_required": isBuyRequired,
    "is_auction_status": isAuctionStatus,
    "video_name": videoName,
    "quantity": quantity,
    "title": title,
    "subtitle": subtitle,
    "name": name,
    "description": description,
    "short_description": shortDescription,
    "message_expert": messageExpert,
    "is_company": isCompany,
    "company": company,
    "website_url": websiteUrl,
    "contact_name": contactName,
    "cell": cell,
    "phone": phone,
    "fax": fax,
    "address_1": address1,
    "address_2": address2,
    "city": city,
    "post_code": postCode,
    "country_id": countryId,
    "country_code": countryCode,
    "country": country,
    "zone_id": zoneId,
    "pickup_zone_id": pickupZoneId,
    "zone": zone,
    "zone_code": zoneCode,
    "latitude": latitude,
    "longitude": longitude,
    "is_vat_applied": isVatApplied,
    "tax_category_id": taxCategoryId,
    "vat_settings": vatSettings,
    "city_tax_settings": cityTaxSettings,
    "city_tax_amount": cityTaxAmount,
    "city_tax_type": cityTaxType,
    "city_tax_excluded": cityTaxExcluded,
    "invoice_recipient_name": invoiceRecipientName,
    "invoice_company_name": invoiceCompanyName,
    "is_invoice_recipient_same_property_address": isInvoiceRecipientSamePropertyAddress,
    "invoice_country_id": invoiceCountryId,
    "invoice_city_name": invoiceCityName,
    "invoice_address": invoiceAddress,
    "invoice_zipcode": invoiceZipcode,
    "is_certified_legality": isCertifiedLegality,
    "is_accept_box": isAcceptBox,
    "is_security_deposit_required": isSecurityDepositRequired,
    "is_additional_charge_required": isAdditionalChargeRequired,
    "is_shipping_promo": isShippingPromo,
    "estimate_revenue": estimateRevenue,
    "buy_price": buyPrice,
    "sort_order": sortOrder,
    "status_id": statusId,
    "is_processed": isProcessed,
    "is_draft": isDraft,
    "is_bid_won": isBidWon,
    "is_bid_confirmed": isBidConfirmed,
    "is_promoted": isPromoted,
    "is_bidable": isBidable,
    "is_approved": isApproved,
    "is_modified": isModified,
    "is_solr": isSolr,
    "suspended": suspended,
    "deleted": deleted,
    "enabled": enabled,
    "added_by_id": addedById,
    "added_by_name": addedByName,
    "added_by_ip": addedByIp,
    "modified_by_id": modifiedById,
    "modified_by_name": modifiedByName,
    "modified_by_ip": modifiedByIp,
    "category_name": categoryName,
    "name_translated": nameTranslated,
    "image": image,
  };


}
