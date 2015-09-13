class SearchResultsPage < SitePrism::Page
  elements :reservations, "[data-hook='reservations_list_item']"
end
