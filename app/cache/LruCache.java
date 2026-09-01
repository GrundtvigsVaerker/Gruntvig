package cache;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.function.Function;

public class LruCache<K, V> {

    private final Map<K, V> cache;

    public LruCache(int capacity) {
        if (capacity <= 0) {
            throw new IllegalArgumentException("capacity must be positive");
        }
        
        cache = new LinkedHashMap<K, V>(capacity, 0.75f, true) {

            @Override
            protected boolean removeEldestEntry(Map.Entry<K, V> eldest) {
                return this.size() > capacity;
            }

        };
    }

    public void put(K key, V value) {
        synchronized (cache) {
            cache.put(key, value);
        }
    }

    public V computeIfAbsent(K key, Function<K, V> mappingFunction) {
        V value;
        synchronized (cache) {
            value = cache.computeIfAbsent(key, mappingFunction);
        }
        return value;
    }

    public V get(K key) {
        synchronized (cache) {
            return cache.get(key);
        }
    }

    public V remove(K key) {
        synchronized (cache) {
            return cache.remove(key);
        }
    }

    public int size() {
        synchronized (cache) {
            return cache.size();
        }
    }

    public void clear() {
        synchronized (cache) {
            cache.clear();
        }
    }
}
