package cache;

import play.cache.Cache;
import viewmodels.AssetMetaViewModel;

import java.util.List;

public class CacheManager {

    private static final String ASSET_META_VIEW_MODELS_CACHE_KEY = "assetMetaViewModels";

    public static void setAssetMetaViewModels(List<AssetMetaViewModel> models) {
        Cache.add(ASSET_META_VIEW_MODELS_CACHE_KEY, models);
    }

    public static List<AssetMetaViewModel> getAssetMetaViewModels() {
        @SuppressWarnings("unchecked")
        var assetMetaViewModels = (List<AssetMetaViewModel>) Cache.get(ASSET_META_VIEW_MODELS_CACHE_KEY, List.class);
        return assetMetaViewModels;
    }

    public static void removeAssetMetaViewModels() {
        Cache.safeDelete(ASSET_META_VIEW_MODELS_CACHE_KEY);
    }

}