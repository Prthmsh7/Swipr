package com.travelswipr.app.ui.screens

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Delete
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import coil.compose.AsyncImage
import coil.request.ImageRequest
import com.travelswipr.app.R
import com.travelswipr.app.data.TravelPlace
import com.travelswipr.app.viewmodel.TravelViewModel

@Composable
fun LikesScreen(viewModel: TravelViewModel) {
    val likedPlaces by viewModel.likedPlaces.collectAsState()
    
    Column(
        modifier = Modifier.fillMaxSize()
    ) {
        // Header
        TopAppBar(
            title = { Text(text = stringResource(R.string.likes)) },
            backgroundColor = MaterialTheme.colors.primary,
            contentColor = Color.White
        )
        
        if (likedPlaces.isEmpty()) {
            // Empty state
            Box(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(16.dp),
                contentAlignment = Alignment.Center
            ) {
                Text(
                    text = "You haven't liked any places yet.\nSwipe right on places you like!",
                    style = MaterialTheme.typography.body1
                )
            }
        } else {
            // List of liked places
            LazyColumn(
                modifier = Modifier.fillMaxSize(),
                contentPadding = PaddingValues(16.dp),
                verticalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                items(likedPlaces) { place ->
                    LikedPlaceCard(
                        place = place,
                        onRemove = { viewModel.removeLikedPlace(place) }
                    )
                }
            }
        }
    }
}

@Composable
fun LikedPlaceCard(
    place: TravelPlace,
    onRemove: () -> Unit
) {
    Card(
        modifier = Modifier.fillMaxWidth(),
        elevation = 4.dp
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .height(120.dp)
        ) {
            // Image
            AsyncImage(
                model = ImageRequest.Builder(LocalContext.current)
                    .data(place.imageUrls.firstOrNull())
                    .crossfade(true)
                    .build(),
                contentDescription = place.name,
                contentScale = ContentScale.Crop,
                modifier = Modifier
                    .width(120.dp)
                    .fillMaxHeight()
            )
            
            // Info
            Column(
                modifier = Modifier
                    .weight(1f)
                    .fillMaxHeight()
                    .padding(12.dp)
            ) {
                Text(
                    text = place.name,
                    style = MaterialTheme.typography.h6,
                    maxLines = 1,
                    overflow = TextOverflow.Ellipsis
                )
                
                Text(
                    text = place.location,
                    style = MaterialTheme.typography.caption,
                    color = MaterialTheme.colors.onSurface.copy(alpha = 0.7f)
                )
                
                Spacer(modifier = Modifier.height(4.dp))
                
                Text(
                    text = "$${place.price} / night",
                    style = MaterialTheme.typography.body2,
                    color = MaterialTheme.colors.primary
                )
                
                Spacer(modifier = Modifier.weight(1f))
                
                // Amenities chips
                Row(
                    horizontalArrangement = Arrangement.spacedBy(4.dp)
                ) {
                    place.amenities.take(2).forEach { amenity ->
                        Text(
                            text = amenity,
                            style = MaterialTheme.typography.caption,
                            color = MaterialTheme.colors.onSurface.copy(alpha = 0.7f),
                            maxLines = 1,
                            overflow = TextOverflow.Ellipsis
                        )
                        
                        if (place.amenities.indexOf(amenity) < place.amenities.take(2).size - 1) {
                            Text(
                                text = "•",
                                style = MaterialTheme.typography.caption,
                                color = MaterialTheme.colors.onSurface.copy(alpha = 0.7f)
                            )
                        }
                    }
                }
            }
            
            // Remove button
            IconButton(
                onClick = onRemove,
                modifier = Modifier.align(Alignment.CenterVertically)
            ) {
                Icon(
                    imageVector = Icons.Default.Delete,
                    contentDescription = "Remove",
                    tint = Color.Gray
                )
            }
        }
    }
} 