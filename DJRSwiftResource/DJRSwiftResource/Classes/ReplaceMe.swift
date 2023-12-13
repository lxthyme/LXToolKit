import RswiftResources

open class DJTest: NSObject {
    @objc public static var icon_search_hot = R.image.icon_search_hot()
    @objc public static var icon_search_refresh = R.image.icon_search_refresh()
    @objc public static var icon_search_bg_hotRank = R.image.icon_search_bg_hotRank()
    @objc public static var icon_search_rankTitle = R.image.icon_search_rankTitle()
    @objc public static var icon_tag_plus = R.image.icon_tag_plus()
    @objc public static var icon_rank1 = R.image.icon_rank1()
    @objc public static var icon_rank2 = R.image.icon_rank2()
    @objc public static var icon_rank3 = R.image.icon_rank3()
    @objc public static var icon_rank4 = R.image.icon_rank4()
    @objc public static var icon_rank5 = R.image.icon_rank5()
    @objc public static var icon_rank6 = R.image.icon_rank6()
    @objc public static var icon_addCart = R.image.icon_addCart()
    @objc public static var dj_plus_member = R.image.dj_plus_member()
    @objc public static var icon_arrow_down = R.image.icon_arrow_down()
    @objc public static var icon_search_delete = R.image.icon_search_delete()
    @objc public static var icon_search = R.image.icon_search()
    // @objc public static var <#icon_name#> = R.image.icon_<#tag_plus#>()
    // @objc public static var <#icon_name#> = R.image.icon_<#tag_plus#>()
    // @objc public static var <#icon_name#> = R.image.icon_<#tag_plus#>()
    // @objc public static var <#icon_name#> = R.image.icon_<#tag_plus#>()
    // @objc public static var <#icon_name#> = R.image.icon_<#tag_plus#>()
    // @objc public static var <#icon_name#> = R.image.icon_<#tag_plus#>()
    static subscript(_ keyPath: String) -> UIImage? {
        return value(forKeyPath: keyPath) as? UIImage;
    }
}

// MARK: - 👀
public extension DJTest {
    @objc static func getRankIcon(from rank: Int) -> UIImage? {
        if(rank <= 0 || rank > 6) {
            return nil;
        }
        // return DJTest[keyPath: "icon_rank\(rank)"];
        return value(forKeyPath: "icon_rank\(rank)") as? UIImage
    }
}
