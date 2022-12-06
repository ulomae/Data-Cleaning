/*
Cleaning Data in SQL Queries
*/


Select *
From [Data Cleaning].dbo.Housing



-- Standardize Date Format


Select saleDateConverted, CONVERT(Date,SaleDate)
From [Data Cleaning].dbo.Housing


Update Housing
SET SaleDate = CONVERT(Date,SaleDate)



-- Populate Property Address data

Select *
From [Data Cleaning].dbo.Housing
--Where PropertyAddress is null
order by ParcelID



Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From [Data Cleaning].dbo.Housing a
JOIN [Data Cleaning].dbo.Housing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From [Data Cleaning].dbo.Housing a
JOIN [Data Cleaning].dbo.Housing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null






-- Change Y and N to Yes and No in "Sold as Vacant" field


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From [Data Cleaning].dbo.Housing
Group by SoldAsVacant
order by 2




Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From [Data Cleaning].dbo.Housing


Update Housing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END






