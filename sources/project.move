module MyModule::ResearchAccess {
    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;
    use std::string::String;

    struct Paper has store, key {
        price: u64,
        content: String,
    }

    public fun publish_paper(owner: &signer, price: u64, content: String) {
        let paper = Paper {
            price,
            content,
        };
        move_to(owner, paper);
    }

    public fun purchase_paper(buyer: &signer, seller: address) acquires Paper {
        let paper = borrow_global_mut<Paper>(seller);
        let payment = coin::withdraw<AptosCoin>(buyer, paper.price);
        coin::deposit<AptosCoin>(seller, payment);
    }
}
