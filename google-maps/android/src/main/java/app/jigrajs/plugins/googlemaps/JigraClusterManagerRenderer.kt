package app.jigrajs.plugins.googlemaps

import android.content.Context
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.model.MarkerOptions
import com.google.maps.android.clustering.ClusterManager
import com.google.maps.android.clustering.view.DefaultClusterRenderer

class JigraClusterManagerRenderer(
    context: Context,
    map: GoogleMap?,
    clusterManager: ClusterManager<JigraGoogleMapMarker>?,
    minClusterSize: Int?
) : DefaultClusterRenderer<JigraGoogleMapMarker>(context, map, clusterManager) {

    init {
        if(minClusterSize != null && minClusterSize > 0) {
            super.setMinClusterSize(minClusterSize)
        }
    }

    override fun onBeforeClusterItemRendered(item: JigraGoogleMapMarker, markerOptions: MarkerOptions) {
        super.onBeforeClusterItemRendered(item, markerOptions)

        item.markerOptions?.let {
            markerOptions.position(it.position)
            markerOptions.title(it.title)
            markerOptions.snippet(it.snippet)
            markerOptions.alpha(it.alpha)
            markerOptions.flat(it.isFlat)
            markerOptions.draggable(it.isDraggable)
            if(null != it.icon) {
                markerOptions.icon(it.icon)
            }
        }
    }
}
