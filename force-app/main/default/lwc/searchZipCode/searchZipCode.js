/**
 * @description       : 
 * @author            : Edgar Santillana
 * @group             : 
 * @last modified on  : 07-30-2024
 * @last modified by  : Edgar Santillana
 * Modifications Log
 * Ver   Date         Author             Modification
 * 1.0   07-30-2024   Edgar Santillana   Initial Version
**/
import { LightningElement, track} from 'lwc';
import searchZipCode from '@salesforce/apex/SearchZipCodeController.searchZipCode'

export default class SearchZipCode extends LightningElement {

    @track zipCode = '';
    @track locationDetailsUS = [];
    @track locationDetailsNONUS = [];
    @track error;

     // List of country codes supported by Zippopotam.us
     countryCodes = ['us', 'ca', 'de', 'fr', 'nl', 'ch', 'at', 'be', 'au', 'nz','mx'];

    handleInputChange(event) {
        this.zipCode = event.target.value;
    }

    searchZipCode() {
        this.locationDetailsUS = [];
        this.locationDetailsNONUS = [];
        this.error = undefined;

        const fetchPromises = this.countryCodes.map(countryCode => 
            searchZipCode({ countryCode, zipCode: this.zipCode })
                .then(result => JSON.parse(result))
                .catch(() => null)
        );

        Promise.allSettled(fetchPromises)
        .then(results => {
            const successfulResults = results
                .filter(result => result.status === 'fulfilled' && result.value !== null)
                .map(result => result.value);

            if (successfulResults.length > 0) {
                console.log('Successful Results: ', successfulResults);
                this.locationDetailsUS = successfulResults
                .filter(result => result['country abbreviation'] === 'US')
                .flatMap(result => 
                    result.places.map(place => ({
                        country: result.country,
                        state: place['state'],
                        placeName: place['place name'],
                        countryAbbreviation: result['country abbreviation'],
                        placeKey: result.country + place['place name']
                    }))
                );
                console.log('Location Details US: ', this.locationDetailsUS);

                this.locationDetailsNONUS = successfulResults
                .filter(result => result['country abbreviation'] != 'US')
                .flatMap(result => 
                    result.places.map(place => ({
                        country: result.country,
                        state: place['state'],
                        placeName: place['place name'],
                        countryAbbreviation: result['country abbreviation'],
                        placeKey: result.country + place['place name']
                    }))
                );

                console.log('Location Details NON US: ', this.locationDetailsNONUS);
            } else {
                this.error = 'No data found for the provided ZIP code in any country.';
            }
        })
        .catch(() => {
            this.error = 'An error occurred while fetching data.';
        });
}
}