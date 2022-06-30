library endpoint;

const getUser = "/api/users/2";
const postCreateTest = "/api/users";
const postCreateAccount = "/auth/register";
const postVerifyOTP = "/auth/verify-register-otp";
const postSignin = "/auth/login";
const getMe = "/accounts/me";
const getRewards = "/accounts/rewards";
const getHotAndSuggestVendor = "/categories?lat={lat}&lng={lng}";
// const getListVendors = "/categories/{category}/vendors";
const getListVendors = "/categories/?cat={category}";
const getVendorsDetail = "/vendors/";
const getVendorByLocation = "/vendors/search-geo?latt={latt}&lng={lng}";
const getVendorByText = "/vendors/search-t?t={textSearch}";
const getVendorDetail = "/vendors/{vendor_id}";
const getSeachVendor =
    "/vendors/?cat={category}&attributes={listAttributeId}&t={textSearch}&lng={lng}&lat={lat}&limit=10&page=1";
const getListVendorsByCategory = "/vendors?cat={category}";

const getListOrders =
    '/orders?limit={limit}&page={page}&cats={cats}&status={status}';
const getDetailOrder = '/orders/{id}';
const getBillByQr = '/orders/qr-bill';
const confirmBillQr = '/orders/confirm-qr-bill';

const postOrder = '/orders';
const getCancelOrder = '/orders/{id}/cancel';
const getListAttributeByCategory = "/vendors/attributes";
const postPreOrderCalculate = "/orders/pre-calc";
const customerGetListAttribute = "/attributes";
const postCreateNewServices = "/vendors/products";
// const getListServices = "/vendors/products";
const getListServices =
    "/vendors/products?limit={limit}&page={page}&active={active}&status={status}";
const putEditServiceItem = "/vendors/products/{service_id}";
const getListBooking =
    "/vendors/orders?status={status}&t={text}&startDate={startDate}&endDate={endDate}&limit={limit}&page={page}";
const getBookingDetail = "/vendors/orders/{bookingId}";
const putVendorUpdateBooking = "/vendors/orders/{bookingId}";
const putVendorCompleteBooking = "/vendors/orders/{bookingId}/receipts";
const getServiceDetail = "/vendors/products/{serviceId}";

const getListVendorByType = "/vendors/search";
const generateImageUrl = "/profile/avatar/s3-url";
const generateImagePost = "/posts/s3-url/";
const generateImageOrderComplete = "/vendors/orders/s3-receipts";
const updateAvatar = "/profile/avatar";
const getDetailOption = "/products/{productId}/options";
const updateServiceThumbnail = "/vendors/products/{serviceId}/thumbnail";

const updateServiceGallery = "/vendors/products/{serviceId}/gallery";

const getListReview = "/vendors/{vendorId}/reviews?limit={limit}&page={page}";
const postCreateReview = "/reviews";
const postCreateReviewForOrder = "/orders/{id}/reviews";

// const getNotifications = "/notifications?limit={limit}&page={page}";
const getNotifications = "/notifications?limit={limit}&page={page}";

const updateReadNotification =
    "/notifications/read?readAll={readStatus}&id={refId}";

const createNewPost = "/posts";
const getListPost = "/posts?limit={limit}&page={page}&tag={tag}";
const getListUserPost = "/accounts/posts?limit={limit}&page={page}&tag={tag}";

const updateInformation = "/profile/";
const getPostById =
    "/posts/{postId}/?parentComment={parentCommentCount}&childComment={childCommentCount}";
const postAddComment = "/posts/{postId}/comments/";
const getMoreComment =
    "/posts/{postId}/comments/?parentId={commentParentId}&limit={parentCommentCount}&page={commentPage}&commentLimit={childCommentCount}&skip={skip}";
const getListMessageDetail = "/chat/{chatRoomId}?limit={limit}&page={page}";
const postAddMessageItem = "/chat/{messageId}";
const getListMessage = "/chat/?limit={limit}&page={page}";
const updateReaction = "/posts/{postId}/reactions";
const updateDeceiveToken = "/accounts/devices";
const logoutAccount = "/accounts/logout";
const signInCheckPhone = "/auth/login-otp";
const signInTelephone = "/auth/verify-login-otp";

//location
const getProvinces = "/locations/provinces";
const getDistrictsByProvince = "/locations/provinces/{id}/districts";
const getWardsByDistrict = "/locations/districts/{id}/wards";
const checkTelephoneSignupCustomer = "/auth/register";
const completeRegister = "/profile/complete";
const updateVendorProfile = "/profile/vendor";
const getFilterVendor =
    "/vendors/search?attributes={attributes}&t={text}&lng={lng}&lat={lat}&limit={limit}&page={page}&minPrice={minPrice}&maxPrice={maxPrice}&cats={cats}&province={province}&district={district}&taglines={taglines}&variant=&subCategory={variant}";
const getSearchHistory = "/vendors/search-history";

const applyVendor = "/vendors";
const getListAffiliate = "/affiliates";
const getListRewardsHistory =
    "/rewards/history?type={type}&limit={limit}&page={page}";

const getVendorDashboard =
    "/vendors/dashboard?startDate={startDate}&endDate={endDate}";
const updateVendorsThumbnail = "/vendors/thumbnail";
const generateUpdateThumbnail = "/vendors/upload/s3-url";
const vendorsGetListReviews =
    "/vendors/reviews?limit={limit}&page={page}&type={type}";
const vendorsReplyComment = "/vendors/reviews/{reviewId}/response";
const forgotPassword = "/accounts/password/recovery";
const verifyForgotPassword = "/accounts/password/verify-recovery";
const changePassword = "/accounts/password";
const getListVoucher =
    "/vouchers?limit={limit}&page={page}&vendorId={vendorId}&type={type}";
const getPosterByCategory =
    "/categories/{category}?limit=20&page={page}&lng={lng}&lat={lat}";
const applicationsVendor = "/vendors/applications";
const vendorGetListStaffs = "/vendors/staffs";
const vendorCreateStaff = "/vendors/staffs";
const customerGetListStaff = "/vendors/{vendorId}/staffs?limit=100&page=1";
const updateStaffForOrder = "/orders/{orderId}/staffs";
const getTaglineByCategory = "/taglines?type&category={category}";
const getChatRoomByVendorId = "/vendors/{vendorId}/chat";
const createChatWithVendor = "/chat/with-vendor/{vendorId}?limit=30&page=1";
const getVariantsByCategory = "/vendors/variants?cat={category}";
const getListSubCategory = "/vendors/subCategories?cat={category}";

const vendorGetVoucher = "/vouchers?type=all&vendorId=&limit=10&page=1";
const vendorsCreateBill = "/vendors/orders/bills";
const getRewardScreen = "/vouchers/main";
const getAppVersion = "/app-version";

const adminGetListOrders =
    "/admin/orders?limit=10&page={page}&t={text}&status={status}&vendorStatus=0&vendorVerifyStatus={vendorStatus}&province={province}&district={district}&cats={cat}&startDate={startDate}&endDate={endDate}";

const adminGetOrderDetail = "/admin/orders/{orderId}";
const adminUpdateOrder = "/admin/orders/{orderId}";
const getMoreHotVendor =
    "/categories/hot-vendor?limit=15&page={page}&lng={lng}&lat={lat}";
const deletePostById = "/posts/{postId}";
const adminCompleteOrder = "/admin/orders/{orderId}/receipts";
const updateBillOrder = "/vendors/orders/{bookingId}/receipt-images";
const vendorGetListMenu = "/vendors/menu";
const vendorCreateMenu = "/vendors/menu";
const updateMenuOrders = "/vendors/orders/{bookingId}/menu";
const updateSubfeeOrders = "/vendors/orders/{bookingId}/sub-fees";
