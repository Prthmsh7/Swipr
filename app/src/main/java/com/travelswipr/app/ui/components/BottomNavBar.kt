package com.travelswipr.app.ui.components

import androidx.compose.material.BottomNavigation
import androidx.compose.material.BottomNavigationItem
import androidx.compose.material.Icon
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Search
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.res.stringResource
import com.travelswipr.app.R
import com.travelswipr.app.Screen

data class BottomNavItem(
    val screen: Screen,
    val icon: ImageVector,
    val titleResId: Int
)

@Composable
fun BottomNavBar(
    currentScreen: Screen,
    onScreenSelected: (Screen) -> Unit
) {
    val items = listOf(
        BottomNavItem(
            screen = Screen.SEARCH,
            icon = Icons.Default.Search,
            titleResId = R.string.search_button
        ),
        BottomNavItem(
            screen = Screen.SWIPE,
            icon = Icons.Default.Home,
            titleResId = R.string.home
        ),
        BottomNavItem(
            screen = Screen.LIKES,
            icon = Icons.Default.Favorite,
            titleResId = R.string.likes
        )
    )
    
    BottomNavigation(
        backgroundColor = MaterialTheme.colors.surface,
        contentColor = MaterialTheme.colors.primary
    ) {
        items.forEach { item ->
            BottomNavigationItem(
                icon = { 
                    Icon(
                        imageVector = item.icon, 
                        contentDescription = stringResource(item.titleResId)
                    ) 
                },
                label = { Text(text = stringResource(item.titleResId)) },
                selected = currentScreen == item.screen,
                onClick = { onScreenSelected(item.screen) },
                selectedContentColor = MaterialTheme.colors.primary,
                unselectedContentColor = Color.Gray.copy(alpha = 0.6f)
            )
        }
    }
} 