package com.travelswipr.app

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material.Scaffold
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.lifecycle.viewmodel.compose.viewModel
import com.travelswipr.app.ui.components.BottomNavBar
import com.travelswipr.app.ui.screens.LikesScreen
import com.travelswipr.app.ui.screens.SearchScreen
import com.travelswipr.app.ui.screens.SwipeScreen
import com.travelswipr.app.ui.theme.TravelSwiprTheme
import com.travelswipr.app.viewmodel.TravelViewModel

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            TravelSwiprTheme {
                TravelSwiprApp()
            }
        }
    }
}

@Composable
fun TravelSwiprApp() {
    val travelViewModel: TravelViewModel = viewModel()
    var currentScreen by remember { mutableStateOf(Screen.SEARCH) }
    
    Scaffold(
        bottomBar = {
            BottomNavBar(
                currentScreen = currentScreen,
                onScreenSelected = { screen ->
                    currentScreen = screen
                }
            )
        }
    ) { paddingValues ->
        when (currentScreen) {
            Screen.SEARCH -> {
                SearchScreen(
                    viewModel = travelViewModel,
                    onSearch = { currentScreen = Screen.SWIPE }
                )
            }
            Screen.SWIPE -> {
                SwipeScreen(viewModel = travelViewModel)
            }
            Screen.LIKES -> {
                LikesScreen(viewModel = travelViewModel)
            }
        }
    }
}

enum class Screen {
    SEARCH, SWIPE, LIKES
} 