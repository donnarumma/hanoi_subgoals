function s = stringDate()
    d = date;
    c = clock;
    s = [d '-h' num2str(c(end-2)) '-m' num2str(c(end-1)) '-s' num2str(c(end))];
end