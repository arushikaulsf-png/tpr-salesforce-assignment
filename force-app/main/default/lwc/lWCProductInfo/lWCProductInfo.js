import { LightningElement, api, wire, track } from 'lwc';
import getPricingForCase from '@salesforce/apex/PricingInfoClass.getPricingForCase';

export default class N26ProductPricing extends LightningElement {
    @api recordId;
    @track pricingList = [];
    
    columns = [
        { label: 'Plan Type', fieldName: 'product' },
        { label: 'Country', fieldName: 'country' },
        {
            label: 'Monthly Fee',
            fieldName: 'monthlyFee',           
            type: 'text'                      
        },
        {
            label: 'ATM Fee',
            fieldName: 'atmFee',               
            type: 'text'                       
        },
        {
            label: 'Card Replacement',
            fieldName: 'cardReplacement',      
            type: 'text'                       
        }
    ];

    @wire(getPricingForCase, { caseId: '$recordId' })
    wiredPricing({ data, error }) {
        if (data) {
            this.pricingList = data;
        } else if (error) {
            this.pricingList = [];
        }
    }

    get hasData() {
        return this.pricingList?.length > 0;
    }
}