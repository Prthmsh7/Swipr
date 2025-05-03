package com.travelswipr.app.ui.screens

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.Button
import androidx.compose.material.Icon
import androidx.compose.material.MaterialTheme
import androidx.compose.material.OutlinedTextField
import androidx.compose.material.Text
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Search
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import com.travelswipr.app.R
import com.travelswipr.app.viewmodel.TravelViewModel

@Composable
fun SearchScreen(
    viewModel: TravelViewModel,
    onSearch: () -> Unit
) {
    var budget by remember { mutableStateOf("") }
    var days by remember { mutableStateOf("") }
    var budgetError by remember { mutableStateOf(false) }
    var daysError by remember { mutableStateOf(false) }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            text = "TravelSwipr",
            style = MaterialTheme.typography.h3,
            color = MaterialTheme.colors.primary,
            modifier = Modifier.padding(bottom = 32.dp)
        )

        Text(
            text = stringResource(R.string.search_hint),
            style = MaterialTheme.typography.subtitle1,
            modifier = Modifier.padding(bottom = 24.dp)
        )

        OutlinedTextField(
            value = budget,
            onValueChange = {
                budget = it.filter { char -> char.isDigit() }
                budgetError = false
            },
            label = { Text(stringResource(R.string.budget_hint)) },
            isError = budgetError,
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number),
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 16.dp)
        )

        OutlinedTextField(
            value = days,
            onValueChange = {
                days = it.filter { char -> char.isDigit() }
                daysError = false
            },
            label = { Text(stringResource(R.string.days_hint)) },
            isError = daysError,
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number),
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 32.dp)
        )

        Button(
            onClick = {
                if (budget.isBlank()) {
                    budgetError = true
                }
                if (days.isBlank()) {
                    daysError = true
                }
                
                if (budget.isNotBlank() && days.isNotBlank()) {
                    viewModel.updateBudget(budget.toInt())
                    viewModel.updateDays(days.toInt())
                    viewModel.searchPlaces()
                    onSearch()
                }
            },
            shape = RoundedCornerShape(12.dp),
            modifier = Modifier
                .fillMaxWidth()
                .height(56.dp)
        ) {
            Icon(
                imageVector = Icons.Default.Search,
                contentDescription = null,
                modifier = Modifier.size(24.dp)
            )
            Spacer(modifier = Modifier.width(8.dp))
            Text(text = stringResource(R.string.search_button))
        }
    }
} 