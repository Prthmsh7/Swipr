package com.travelswipr.app.ui.screens

import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.foundation.gestures.detectDragGestures
import androidx.compose.foundation.layout.*
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Close
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.unit.dp
import com.travelswipr.app.data.TravelPlace
import com.travelswipr.app.ui.components.PlaceCard
import com.travelswipr.app.ui.theme.TravelGreen
import com.travelswipr.app.ui.theme.TravelRed
import com.travelswipr.app.viewmodel.TravelViewModel
import kotlin.math.abs

@Composable
fun SwipeScreen(viewModel: TravelViewModel) {
    val travelPlaces by viewModel.travelPlaces.collectAsState()
    val currentIndex by viewModel.currentPlaceIndex.collectAsState()
    
    Box(
        modifier = Modifier.fillMaxSize()
    ) {
        if (travelPlaces.isEmpty()) {
            // Show loading or empty state
            Text(
                text = "No places found. Try adjusting your search.",
                style = MaterialTheme.typography.body1,
                modifier = Modifier
                    .padding(16.dp)
                    .align(Alignment.Center)
            )
        } else if (currentIndex >= travelPlaces.size) {
            // Show end of results
            Text(
                text = "No more places to show.",
                style = MaterialTheme.typography.body1,
                modifier = Modifier
                    .padding(16.dp)
                    .align(Alignment.Center)
            )
        } else {
            // Show swipeable card
            SwipeableCard(
                place = travelPlaces[currentIndex],
                onSwipeLeft = { viewModel.dislikeCurrentPlace() },
                onSwipeRight = { viewModel.likeCurrentPlace() },
                modifier = Modifier
                    .padding(16.dp)
                    .fillMaxWidth()
                    .height(500.dp)
                    .align(Alignment.Center)
            )
            
            // Action buttons
            Row(
                modifier = Modifier
                    .padding(16.dp)
                    .fillMaxWidth()
                    .align(Alignment.BottomCenter),
                horizontalArrangement = Arrangement.SpaceEvenly
            ) {
                // Dislike button
                FloatingActionButton(
                    onClick = { viewModel.dislikeCurrentPlace() },
                    backgroundColor = TravelRed,
                    modifier = Modifier.size(64.dp)
                ) {
                    Icon(
                        Icons.Default.Close,
                        contentDescription = "Dislike",
                        tint = Color.White,
                        modifier = Modifier.size(32.dp)
                    )
                }
                
                // Like button
                FloatingActionButton(
                    onClick = { viewModel.likeCurrentPlace() },
                    backgroundColor = TravelGreen,
                    modifier = Modifier.size(64.dp)
                ) {
                    Icon(
                        Icons.Default.Favorite,
                        contentDescription = "Like",
                        tint = Color.White,
                        modifier = Modifier.size(32.dp)
                    )
                }
            }
        }
    }
}

@Composable
fun SwipeableCard(
    place: TravelPlace,
    onSwipeLeft: () -> Unit,
    onSwipeRight: () -> Unit,
    modifier: Modifier = Modifier
) {
    val screenWidth = with(LocalDensity.current) { 
        LocalDensity.current.run { 
            // Approximate screen width
            360.dp.toPx() 
        } 
    }
    
    // Drag state
    var offset by remember { mutableStateOf(Offset.Zero) }
    val rotation by animateFloatAsState(targetValue = (offset.x / 60).coerceIn(-40f, 40f))
    
    // Threshold for swipe detection
    val threshold = screenWidth / 4
    
    // Swipe actions
    LaunchedEffect(offset) {
        if (offset.x < -threshold) {
            onSwipeLeft()
            offset = Offset.Zero
        } else if (offset.x > threshold) {
            onSwipeRight()
            offset = Offset.Zero
        }
    }
    
    // Background swipe indicators
    Box(modifier = modifier) {
        // Like indicator (right swipe)
        if (offset.x > 0) {
            Surface(
                modifier = Modifier.matchParentSize(),
                color = TravelGreen.copy(alpha = (abs(offset.x) / threshold).coerceIn(0f, 0.8f)),
                shape = MaterialTheme.shapes.large
            ) {
                Box(contentAlignment = Alignment.Center) {
                    Text(
                        "LIKE",
                        style = MaterialTheme.typography.h3,
                        color = Color.White
                    )
                }
            }
        }
        
        // Dislike indicator (left swipe)
        if (offset.x < 0) {
            Surface(
                modifier = Modifier.matchParentSize(),
                color = TravelRed.copy(alpha = (abs(offset.x) / threshold).coerceIn(0f, 0.8f)),
                shape = MaterialTheme.shapes.large
            ) {
                Box(contentAlignment = Alignment.Center) {
                    Text(
                        "NOPE",
                        style = MaterialTheme.typography.h3,
                        color = Color.White
                    )
                }
            }
        }
        
        // Main card content
        Card(
            modifier = Modifier
                .graphicsLayer {
                    translationX = offset.x
                    rotationZ = rotation
                }
                .pointerInput(Unit) {
                    detectDragGestures(
                        onDragEnd = {
                            // Return to center if not past threshold
                            if (abs(offset.x) < threshold) {
                                offset = Offset.Zero
                            }
                        },
                        onDrag = { change, dragAmount ->
                            change.consume()
                            offset = Offset(offset.x + dragAmount.x, 0f)
                        }
                    )
                }
                .fillMaxSize(),
            elevation = 8.dp
        ) {
            PlaceCard(place = place)
        }
    }
} 