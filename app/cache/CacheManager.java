package cache;

import play.cache.Cache;
import viewmodels.AssetMetaViewModel;

import java.util.List;

public class CacheManager {

    private static final String ASSET_ROOT_TYPE_META_VIEW_MODELS_CACHE_KEY = "assetRootTypeMetaViewModels";

    public static void setAssetRootTypeMetaViewModels(List<AssetMetaViewModel> models) {
        Cache.add(ASSET_ROOT_TYPE_META_VIEW_MODELS_CACHE_KEY, models);
    }

    public static List<AssetMetaViewModel> getAssetRootTypeMetaViewModels() {
        @SuppressWarnings("unchecked")
        var assetMetaViewModels = (List<AssetMetaViewModel>) Cache.get(ASSET_ROOT_TYPE_META_VIEW_MODELS_CACHE_KEY, List.class);
        return assetMetaViewModels;
    }

    public static void removeAssetRootTypeMetaViewModels() {
        Cache.safeDelete(ASSET_ROOT_TYPE_META_VIEW_MODELS_CACHE_KEY);
    }

    public static void removeAll() {
        removeAssetRootTypeMetaViewModels();
    }

}